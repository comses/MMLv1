#!/usr/bin/python
#
############################################################################
#
# MODULE:       	r.landcover.update
# AUTHOR(S):		Isaac Ullah, Michael Barton, Arizona State University
# PURPOSE:		Updates a map of landcover by the amounts specified in an impacts
#               	map
# ACKNOWLEDGEMENTS:	National Science Foundation Grant #BCS0410269 
# COPYRIGHT:		(C) 2009 by Isaac Ullah, Michael Barton, Arizona State University
#			This program is free software under the GNU General Public
#			License (>=v2). Read the file COPYING that comes with GRASS
#			for details.
#
#############################################################################


#%Module
#%  description: Updates a map of landcover by the amounts specified in an impacts map
#%END

#%option
#% key: inmap
#% type: string
#% gisprompt: old,cell,raster
#% description: input landcover map (values coded 0-max)
#% required : yes
#%END

#%option
#% key: impacts
#% type: string
#% gisprompt: old,cell,raster
#% description: input map of impacts on landcover values
#% required : yes
#%END

#%option
#% key: villages
#% type: string
#% gisprompt: old,cell,raster
#% description: input map of village locations (one map with all villages, coded as the landcover value for village surfaces)
#% required : yes
#%END

#%option
#% key: costsurf
#% type: string
#% gisprompt: old,cell,raster
#% description: input map(s) of walking costs from village locations (as output from r.walk, comma sep for multiple)
#% multiple: yes
#% required : yes
#%END

#%option
#% key: population
#% type: integer
#% description: number of people in the village(s) (comma sep for multiple)
#% multiple: yes
#% required : yes
#%END

#%option
#% key: sfertil
#% type: string
#% gisprompt: old,cell,raster
#% description: map of current soil fertility
#% required : yes
#%END

#%option
#% key: sdepth
#% type: string
#% gisprompt: old,cell,raster
#% description: map of current soil depths
#% required : yes
#%END

#%option
#% key: wooduse
#% type: string
#% description: number of kilograms of wood used per person per year
#% answer: 1662.98
#% required : yes
#%END

#%option
#% key: intensity
#% type: string
#% description: intensity of woodgathering (kilograms of wood gathered per square meter per year)
#% answer: 0.08
#% required : yes
#%END

#%option
#% key: max
#% type: string
#% description: maximum value for landcover maps (number for climax veg)
#% answer: 50.0
#% required : yes
#%END

#%option
#% key: outmap
#% type: string
#% gisprompt: string
#% description: land cover output map name (no prefix)
#% answer: landcover
#% required : yes
#%END

#%option
#% key: scripts_path
#% type: string
#% gisprompt: string
#% description: path to directory containing LandDyn scripts files (e.g., r.catchment.py)
#% required : yes
#%END

#%option
#% key: lc_rules
#% type: string
#% description: Path to reclass rules file for making a "labels" map. If no rules specified, no labels map will be made.
#% answer:
#% required : no
#%END

#%option
#% key: lc_color
#% type: string
#% description: Path to color rules file for landcover map
#% answer:
#% required : no
#%END

#%flag
#% key: s
#% description: -s Output text file of land-use stats from the simulation (will be named "prefix"_luse_stats.txt, and will be overwritten if you run the simulation again with the same prefix)
#%END

#%flag
#% key: r
#% description: -r Save the map of vegetation regrowth rates.
#%END

import sys
import os
import subprocess
import tempfile
import random
grass_install_tree = os.getenv('GISBASE')
sys.path.append(grass_install_tree + os.sep + 'etc' + os.sep + 'python')
import grass.script as grass

#main block of code starts here
def main():
    #setting up variables for use later on
    inmap = os.getenv('GIS_OPT_inmap') 
    impacts = os.getenv('GIS_OPT_impacts') 
    villages = os.getenv('GIS_OPT_villages')
    sfertil = os.getenv('GIS_OPT_sfertil') 
    sdepth = os.getenv('GIS_OPT_sdepth') 
    outmap = os.getenv('GIS_OPT_outmap') 
    max = os.getenv('GIS_OPT_max') 
    population = os.getenv("GIS_OPT_population").split(',')
    wooduse = (float((os.getenv("GIS_OPT_wooduse"))))
    intensity = (float((os.getenv("GIS_OPT_intensity"))))
    costsurf = os.getenv("GIS_OPT_costsurf").split(',')
    lc_rules = os.getenv('GIS_OPT_lc_rules') 
    lc_color = os.getenv('GIS_OPT_lc_color') 
    scripts_path = os.getenv('GIS_OPT_scripts_path')
    txtout = outmap + '_landcover_stats.txt'
    temp_rate = 'temp_rate'
    temp_lcov1 = 'temp_first_lcov' 
    temp_lcov = 'temp_lcov'
    temp_reclass = 'temp_reclass'
    tempbiomass = "temporary_map_of_above_ground_biomass"
    tempreducedbiomass = "temporary_map_of_above_ground_biomass_reduced_by_impacts"
    patchedimpacts = "temporary_map_of_impacts_to_above_ground_biomass"
    reclass_out = outmap + '_labels'
    grass.message("\nStarting...")
    #checking to make sure the same number of catchment maps and population numbers were given
    if len(population) != len(costsurf):
        sys.exit("ERROR! You must have the same number of cost-surface maps as there are numbers of populations! \nYou entered %s cost-surface(s): \"costsurf=%s\", and %s population(s): \"population=%s\".\nPlease edit these input variables and try again.\n" % (len(costsurf), os.getenv("GIS_OPT_costsurf"), len(population), os.getenv("GIS_OPT_population")))
    #set up some recode rules for tranlating veg type into above ground biomass and back
    recodeto = tempfile.NamedTemporaryFile()
    recodeto.write('0.000:5.000:0.000:0.100\n5.000:18.500:0.100:0.660\n18.500:35.000:0.660:0.740\n35.000:50.000:0.740:1.910')
    recodeto.flush()
    recodefrom = tempfile.NamedTemporaryFile()
    recodefrom.write('0.000:0.100:0.000:5.000\n0.100:0.660:5.000:18.500\n0.660:0.740:18.500:35.000\n0.740:1.910:35.000:50.000')
    recodefrom.flush()
    # calculating rate of regrowth based on current soil fertility and depths. Recoding fertility (0 to 100) and depth (0 to >= 1) with a power regression curve from 0 to 1, then taking the mean of the two as the regrowth rate
    grass.message("Calculating vegetation regrowth rate.")
    grass.mapcalc('${temp_rate}=if(${sdepth} <= 1.0, ( ( ( (-0.000118528 * (exp(${sfertil},2.0))) + (0.0215056 * ${sfertil}) + 0.0237987 ) + ( ( -0.000118528 * (exp((100*${sdepth}),2.0))) + (0.0215056 * (100*${sdepth})) + 0.0237987 ) ) / 2.0 ), ( ( ( (-0.000118528 * (exp(${sfertil},2.0))) + (0.0215056 * ${sfertil}) + 0.0237987 ) + 1.0) / 2.0 ) )', quiet = True, temp_rate = temp_rate,  sdepth = sdepth,  sfertil = sfertil)
#---------------Starting woodgathering routine--------------------
    #Checking to see if there is a MASK in place, and if so temporarily renaming it so we can use our own MASK of areas that have less than scrub (grass and bareland, below value 5)
    if "MASK" in grass.list_grouped('rast')[grass.gisenv()['MAPSET']]:
        grass.message('There is already a MASK in place, temporarily setting this MASK aside. \nThe MASK will be restored when the module finishes')
        ismask = 1
        tempmask = 'mask_%i' % random.randint(0,100)
        grass.run_command('g.rename', quiet = "True", rast = 'MASK,' + tempmask)
    else:
        ismask = 0
    grass.mapcalc('MASK=if(isnull(${inmap}), null(), if(${inmap} <= 5, null(), if(isnull(${villages}), 1, null())))', quiet = True, inmap = inmap,  villages = villages)
    #Looping through all of the input cost-surface maps/populations. Construct some temp map names and lists of these maps for use later on. Calculating the size of  of the woodgathering catchment for each site using the input variables, and using r.catchment to make a catchment map for each site. Run r.random to make a map of randmoly selected cells inthe catchment for 20% of the catchment size. These are the areas where wood will be gathered this year.
    impactmaps = []
    catchmentmaps = []
    areadict = {}
    for n, i in enumerate(population):
        catchmentmap = "temporary_woodgathering_catchment_map_%s" % (n+1)
        gathimpacts = "temporary_map_of_wood_gathering_impacts_%s" % (n+1)
        impactmaps.append(gathimpacts)
        catchmentmaps.append(catchmentmap)
        #note that this is FIVE TIMES the size really needed. We are going to randomly sample this area at 20%, so we need it this big.
        area = 5*((int(i) * wooduse) * intensity)
        areadict["Village %s" % (n+1)] = area
        grass.message("Determining woodgathering catchment for location %s" % (n+1))
        grass.run_command(scripts_path + 'r.catchment.py', quiet = 'True', elev = "donotworryaboutthis", incost = costsurf[n], vect = "alsodonotworryabouthis", buffer = catchmentmap, area = area, mapval = '1')
        grass.run_command('r.random', overwrite = 'True', quiet = 'True',  input = catchmentmap, n = '20%', raster_output = gathimpacts)
    #don't need the mask anymore
    grass.run_command('g.remove', quiet = True, rast = 'MASK')
    #loop through list of temp maps to make the strings needed to run the next commands
    mapstring = impactmaps[0]
    for item in impactmaps:
        if item not in mapstring:
            mapstring = mapstring + ',' + item
    catchstring = catchmentmaps[0]
    for item in catchmentmaps:
        if item not in catchstring:
            catchstring = catchstring + ',' + item
    #make temp map of the input landcover recoded to biomass values
    grass.run_command('r.recode', overwrite = 'True', quiet = 'True',  input = inmap, output = tempbiomass, rules = recodeto.name) 
    #If there are more than one catchment map, use r.series to sum up the catchment maps, and calculate the output map of reduced biomass, else, just calculate the map of reduced biomass from the one catchment map  
    grass.message("Applying woodgathering impacts")
    if len(costsurf) > 1:
        grass.run_command('r.series', overwrite = 'True', quiet = 'True', input = mapstring, output = patchedimpacts, method = 'sum')
        grass.mapcalc('${outmap}=if(isnull(${patchedimpacts}), ${inmap}, ${inmap} - (${intensity} * ${patchedimpacts}))', quiet = True, outmap = tempreducedbiomass, inmap = tempbiomass, intensity = intensity, patchedimpacts = patchedimpacts)
    else:
        grass.mapcalc('${outmap}=if(isnull(${patchedimpacts}), ${inmap}, ${inmap} - (${intensity} * ${patchedimpacts}))', quiet = True, outmap = tempreducedbiomass, inmap = tempbiomass, intensity = intensity, patchedimpacts = impactmaps[0])
    #now recode the reduced biomass map back to landcover values
    grass.run_command('r.recode', overwrite = 'True', quiet = 'True',  input = tempreducedbiomass, output = temp_lcov1, rules = recodefrom.name)
#----------done with woodgathing routine----------
    #applying the agent impacts to the landscape after (in addition to) woodgathering and then regrowing veg in unimpacted areas using the calculated regrowth rate
    grass.message("Applying agent impacts")
    grass.mapcalc('${temp_lcov}=if(isnull(${impacts}) && ${inmap} >= (${max} - ${temp_rate}), ${max}, if(isnull(${impacts}), (${inmap} + ${temp_rate}), if(${inmap} >= ${impacts}, (${inmap} - ${impacts}), 0 )))', quiet = True, temp_lcov = temp_lcov, max = max, inmap = temp_lcov1, impacts = impacts, temp_rate = temp_rate)
    #checking total area of updated cells
    statdict = grass.parse_command('r.stats', quiet = True,  flags = 'Aan', input = impacts, fs = '=', nv ='*')
    sumofimpacts = 0.0
    for x, y in statdict.iteritems():
        sumofimpacts = sumofimpacts + float(y)
    #now we patch the final map and give it nice colors
    grass.message("Creating output landcover map")
    grass.message('Total area of impacted zones = %s square meters\n' % sumofimpacts)
    grass.mapcalc('${outmap}=if(isnull(${villages}), ${temp_lcov}, ${villages})', quiet = True, outmap = outmap, villages = villages, temp_lcov = temp_lcov)
    try:
        grass.run_command('r.colors',  quiet = True,  map = outmap, rules = lc_color)
    except:
        pass
    if bool(os.getenv('GIS_OPT_lc_rules')) is False:
        grass.message( "No Labels reclass rules specified, so no Labels map will be made")
    else:
        grass.message( 'Creating reclassed labeled landcover map')
        grass.run_command('r.reclass', quiet = True,  input = outmap,  output = temp_reclass,  rules = lc_rules)
        grass.mapcalc('${out}=${input}', quiet = True, out = reclass_out, input = temp_reclass)
        grass.run_command('r.colors',  quiet = True,  map = reclass_out,  rules = lc_color)
        grass.run_command('g.remove',  quiet =True, rast = 'temp_reclass')
    #creating optional output text file of stats. Stats are gathered, then parsed into an easily analyzed comma seperated format.
    if os.getenv('GIS_FLAG_s') == '1':
        grass.message("\nWriting stats to stats file: %s" % txtout)
        village_string = ""
        wood_impact_string = ""
        for x, y in sorted(set(areadict.iteritems())):
            village_string = village_string + "Woodgathering impacts for " + x + ","
            wood_impact_string = wood_impact_string + str(y) + ","
        dict1 = grass.parse_command('r.stats', quiet = True, flags = 'ani', input = outmap, fs = '=')
        lcov_string = ""
        for x in range(51):
            try:
                lcov_string = lcov_string + str(dict1[str(x)]) + ","
            except:
                lcov_string = lcov_string + "0,"
        f = file(txtout,  'a')
        if f.tell() == 0:
             f.write('Landcover and landuse stats. All numbers are area in square meters.\n\n,,,,,,,,,,,,,Landcover Category Numbers\nLandcover Map Name,Total farming and grazing impacts,%s0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50\n' % village_string)
        f.write("%s,%s,%s%s\n" % (outmap, sumofimpacts, wood_impact_string, lcov_string))
        f.close()
    grass.message('Cleaning up...')
    #Check for renamed MASK and reinstate it if necessary, and then clean up!
    if ismask == 1:
        grass.message('Reinstating original MASK...')
        grass.run_command('g.rename', quiet = "True", rast = tempmask +',MASK')
    if len(costsurf) > 1:
        grass.run_command('g.remove', quiet = 'True', rast = tempbiomass + ',' + tempreducedbiomass + ',' + patchedimpacts + ',' + mapstring + ',' + catchstring + ',' + temp_lcov + ',' + temp_lcov1)
    else:
        grass.run_command('g.remove', quiet = 'True', rast = tempbiomass + ',' + tempreducedbiomass + ',' + mapstring + ',' + catchstring)
    if os.getenv('GIS_FLAG_r') == '1':
        grass.run_command('g.rename', quiet = True, rast=temp_rate + ',' + outmap +'_regrowth_rate')
    else:
        grass.run_command('g.remove',  quiet =True, rast = temp_rate)
    return grass.message("Done.\n\n")

# here is where the code in "main" actually gets executed. This way of programming is neccessary for the way g.parser needs to run.
if __name__ == "__main__":
    if ( len(sys.argv) <= 1 or sys.argv[1] != "@ARGS_PARSED@" ):
        os.execvp("g.parser", [sys.argv[0]] + sys.argv)
    else:
        main()
