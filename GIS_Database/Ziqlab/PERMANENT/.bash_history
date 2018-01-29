r.mapcalc PaleoDEM = if(isnull(Basins_Patched@Whole_AreaPaleDEM),null(),Project_area_10m_DEM_PALEOSURFACE_INTERP2@Whole_AreaPaleDEM)
exit
r.soildepth.py elev=PaleoDEM@Project_Area bedrock=PaleoBDRK soildepth=PaleoSDEPTH_init min=0.0001 max=20.0 slopebreaks=15,0.5;45,0.15 curvebreaks=-0.015,-0.5;0.015,0.5 smoothingtype=median smoothingsize=3
r.soildepth.py&
exit
exit
g.copy rast=Ziq_K_fact_filled_smoothed@Soils,Init_Kfactor
g.copy rast=Natural_Landcover_8500BP_FINAL@Vegetation,Init_Landcover
r.colors map=Init_Landcover@Project_Area rules=/home/iullah/Scripts_Working_Dir/rules/luse_colors.txt
exit
g.remove rast=Init_Kfactor@Project_Area
g.copy rast=Ziq_K_fact_FINAL@Soils,Init_Kfactor
exit
r.mapcalc fertility = if(isnull(PaleoDEM@Project_Area),null(),100)
r.mapcalc friction = if(isnull(PaleoDEM@Project_Area),null(),1)
exit
r.landscape.evol.py elev=PaleoDEM@PERMANENT initbdrk=PaleoBDRK@PERMANENT K=Init_Kfactor@PERMANENT Kt=0.0001 loadexp=1.5 kappa=1 C=Init_Landcover@PERMANENT rain=10.13 R=8.78 storms=99 stormlength=12 speed=1.4 cutoff1=0.9 cutoff2=3 cutoff3=9 smoothing=no prefx=test1_ outdem=elevation outsoil=soildepth number=10
r.what --v -f -n input=y00002_ED_rate@temporary_Run1 east_north=752828.034286,3599019.177662
r.what --v -f -n input=y00002_ED_rate@temporary_Run1 east_north=754766.539293,3600114.854405
r.what --v -f -n input=y00002_ED_rate@temporary_Run1 east_north=753797.286789,3601168.389735
r.what --v -f -n input=y00002_ED_rate@temporary_Run1 east_north=750088.842428,3601168.389735
r.what --v -f -n input=y00002_ED_rate@temporary_Run1 east_north=758390.700828,3594973.601995
r.what --v -f -n input=y00001_ED_rate@temporary_Run1 east_north=749330.296990,3602980.470502
r.what --v -f -n input=y00001_ED_rate@temporary_Run1 east_north=749456.721230,3602854.046263
r.what --v -f -n input=y00001_ED_rate@temporary_Run1 east_north=749456.721230,3602854.046263
r.what --v -f -n input=y00001_ED_rate@temporary_Run1 east_north=756831.468539,3602011.217999
r.what --v -f -n input=y00001_ED_rate@temporary_Run1 east_north=756831.468539,3602053.359412
r.what --v -f -n input=y00001_ED_rate@temporary_Run1 east_north=756831.468539,3602053.359412
r.what --v -f -n input=y00001_ED_rate@temporary_Run1 east_north=756873.609953,3602053.359412
r.what --v -f -n input=y00001_ED_rate@temporary_Run1 east_north=751162.663596,3603193.411425
r.what --v -f -n input=y00001_ED_rate@temporary_Run1 east_north=750727.967070,3603077.492352
r.what --v -f -n input=y00001_ED_rate@temporary_Run1 east_north=752278.384679,3603570.148415
r.what --v -f -n input=y00001_ED_rate@temporary_Run1 east_north=752571.804834,3603044.890112
r.what --v -f -n input=y00001_ED_rate@temporary_Run1 east_north=752582.672247,3603070.247410
r.what --v -f -n input=y00001_ED_rate@temporary_Run1 east_north=752394.303752,3603113.717062
r.what --v -f -n input=y00001_ED_rate@temporary_Run1 east_north=751423.481511,3603294.840615
r.what --v -f -n input=y00001_ED_rate@temporary_Run1 east_north=751014.142283,3603110.094591
r.what --v -f -n input=y00001_ED_rate@temporary_Run1 east_north=751923.382516,3603410.759688
r.what --v -f -n input=test1_ED_rate0001@PERMANENT east_north=751619.094948,3603432.494515
r.what --v -f -n input=test1_ED_rate0001@PERMANENT east_north=751698.789311,3603345.555210
r.what --v -f -n input=test1_ED_rate0001@PERMANENT east_north=751126.438885,3603186.166483
r.what --v -f -n input=test1_ED_rate0001@PERMANENT east_north=751235.113017,3603215.146252
r.what --v -f -n input=test1_ED_rate0001@PERMANENT east_north=751629.962361,3603102.849649
r.what --v -f -n input=test1_ED_rate0001@PERMANENT east_north=752061.036416,3603186.166483
r.what --v -f -n input=test1_ED_rate0001@PERMANENT east_north=752227.670084,3603142.696831
r.landscape.evol.py elev=PaleoDEM@PERMANENT initbdrk=PaleoBDRK@PERMANENT Kt=0.0001 loadexp=1.5 kappa=1 rain=10.13 R=8.78 storms=99 stormlength=12 speed=1.4 cutoff1=0.9 cutoff2=3 cutoff3=9 smoothing=no prefx=nomaps1_ outdem=elevation outsoil=soildepth number=10
r.what --v -f -n input=test1_ED_rate0003@PERMANENT east_north=751180.775951,3603113.717062
r.what --v -f -n input=test1_ED_rate0003@PERMANENT east_north=751169.908538,3603128.206947
r.what --v -f -n input=test1_ED_rate0003@PERMANENT east_north=751159.041125,3603164.431657
r.what --v -f -n input=test1_ED_rate0003@PERMANENT east_north=751336.542206,3603233.258607
r.what --v -f -n input=test1_ED_rate0003@PERMANENT east_north=751481.441048,3603309.330499
r.what --v -f -n input=test1_ED_rate0003@PERMANENT east_north=751865.422979,3603446.984399
r.what --v -f -n input=test1_ED_rate0003@PERMANENT east_north=751974.097111,3603396.269804
r.what --v -f -n input=test1_ED_rate0003@PERMANENT east_north=752035.679118,3603454.229341
r.what --v -f -n input=test1_ED_rate0003@PERMANENT east_north=752053.791474,3603530.301233
r.what --v -f -n input=test1_ED_rate0003@PERMANENT east_north=751865.422979,3603523.056291
r.what --v -f -n input=test1_ED_rate0003@PERMANENT east_north=751108.326530,3603378.157449
r.what --v -f -n input=test1_ED_rate0003@PERMANENT east_north=751021.387225,3603226.013665
r.what --v -f -n input=test1_ED_rate0003@PERMANENT east_north=750861.998499,3603012.287873
r.what --v -f -n input=test1_ED_rate0003@PERMANENT east_north=750858.376028,3603117.339533
r.what --v -f -n input=test1_ED_rate0003@PERMANENT east_north=750829.396259,3603142.696831
r.what --v -f -n input=test1_ED_rate0003@PERMANENT east_north=750546.843517,3603211.523781
r.what --v -f -n input=test1_ED_rate0003@PERMANENT east_north=750659.140120,3603291.218144
r.what --v -f -n input=Init_Kfactor@PERMANENT east_north=752771.040741,3603287.595673
r.what --v -f -n input=Init_Kfactor@PERMANENT east_north=752198.690316,3603262.238375
r.what --v -f -n input=Init_Kfactor@PERMANENT east_north=752531.957652,3603360.045094
r.what --v -f -n input=Init_Kfactor@PERMANENT east_north=752535.580123,3603363.667565
r.what --v -f -n input=Init_Kfactor@PERMANENT east_north=752553.692478,3603363.667565
r.what --v -f -n input=Init_Kfactor@PERMANENT east_north=752560.937420,3603363.667565
r.what --v -f -n input=Init_Kfactor@PERMANENT east_north=755272.236251,3601505.521040
r.what --v -f -n input=Init_Kfactor@PERMANENT east_north=747981.771768,3599398.450381
r.what --v -f -n input=Init_Kfactor@PERMANENT east_north=744399.751646,3600325.561471
r.what --v -f -n input=Init_Kfactor@PERMANENT east_north=751310.943411,3601336.955388
r.what --v -f -n input=Init_Kfactor@PERMANENT east_north=760961.327033,3596996.389828
r.what --v -f -n input=Init_Kfactor@PERMANENT east_north=759233.529092,3595437.157540
r.what --v -f -n input=Init_Kfactor@PERMANENT east_north=754640.115053,3598387.056464
r.what --v -f -n input=Init_Kfactor@PERMANENT east_north=750636.680799,3600030.571578
r.what --v -f -n input=Init_Kfactor@PERMANENT east_north=747602.499049,3599272.026141
r.what --v -f -n input=Init_Kfactor@PERMANENT east_north=745621.852629,3599946.288752
r.what --v -f -n input=nomaps1_ED_rate0001@PERMANENT east_north=757927.145283,3598429.197877
r.what --v -f -n input=nomaps1_ED_rate0001@PERMANENT east_north=757547.872564,3600451.985710
r.what --v -f -n input=nomaps1_ED_rate0001@PERMANENT east_north=747602.499049,3601379.096801
r.what --v -f -n input=nomaps1_ED_rate0001@PERMANENT east_north=749035.307098,3600494.127124
g.mremove -f rast=test1_*
r.reclass input=Init_Landcover@PERMANENT output=Init_Landcover.C_factor rules=/home/medland/APSIM/Rules/cfactor_recode_rules.txt
r.reclass input=Init_Landcover@PERMANENT output=Init_Landcover.C_factor rules=/home/medland/APSIM/Rules/cfactor_recode_rules_old.txt
r.recode input=Init_Landcover@PERMANENT output=Init_Landcover.C_factor rules=/home/medland/APSIM/Rules/cfactor_recode_rules.txt
r.what --v -f -n input=Init_Landcover.C_factor@PERMANENT east_north=747981.771768,3600536.268537
r.what --v -f -n input=Init_Landcover.C_factor@PERMANENT east_north=746043.266761,3598387.056464
r.what --v -f -n input=Init_Landcover.C_factor@PERMANENT east_north=743641.206209,3600746.975603
r.what --v -f -n input=Init_Landcover.C_factor@PERMANENT east_north=755904.357449,3597839.218092
r.what --v -f -n input=Init_Landcover.C_factor@PERMANENT east_north=745832.559695,3598892.753422
r.what --v -f -n input=Init_Landcover.C_factor@PERMANENT east_north=747771.064702,3599609.157447
r.landscape.evol.py elev=PaleoDEM@PERMANENT initbdrk=PaleoBDRK@PERMANENT K=Init_Kfactor@PERMANENT Kt=0.0001 loadexp=1.5 kappa=1 C=Init_Landcover.C_factor@PERMANENT rain=10.13 R=8.78 storms=99 stormlength=12 speed=1.4 cutoff1=0.9 cutoff2=3 cutoff3=9 smoothing=no prefx=maps1_ outdem=elevation outsoil=soildepth number=1
r.landscape.evol.py elev=PaleoDEM@PERMANENT initbdrk=PaleoBDRK@PERMANENT K=Init_Kfactor@PERMANENT Kt=0.0001 loadexp=1.5 kappa=1 C=Init_Landcover.C_factor@PERMANENT rain=10.13 R=8.78 storms=99 stormlength=12 speed=1.4 cutoff1=0.9 cutoff2=3 cutoff3=9 smoothing=no prefx=maps1_ outdem=elevation outsoil=soildepth number=10
r.what --v -f -n input=maps1_ED_rate@PERMANENT east_north=753670.862550,3599019.177662
r.what --v -f -n input=maps1_ED_rate@PERMANENT east_north=757379.306911,3595226.450474
r.what --v -f -n input=maps1_ED_rate@PERMANENT east_north=758264.276588,3599777.723099
r.what --v -f -n input=maps1_ED_rate@PERMANENT east_north=755019.387772,3600999.824082
r.what --v -f -n input=maps1_ED_rate@PERMANENT east_north=750173.125254,3600746.975603
r.what --v -f -n input=maps1_ED_rate@PERMANENT east_north=752238.054501,3598260.632224
r.what --v -f -n input=maps1_ED_rate@PERMANENT east_north=748276.761660,3599482.733207
r.what --v -f -n input=maps1_ED_rate@PERMANENT east_north=745621.852629,3598682.046356
r.what --v -f -n input=maps1_ED_rate@PERMANENT east_north=745621.852629,3600704.834190
r.what --v -f -n input=maps1_ED_rate@PERMANENT east_north=750046.701015,3601084.106908
r.what --v -f -n input=maps1_ED_rate@PERMANENT east_north=766018.296617,3595690.006019
r.what --v -f -n input=maps1_ED_rate@PERMANENT east_north=766734.700641,3601252.672561
r.what --v -f -n input=maps1_ED_rate@PERMANENT east_north=755398.660491,3601463.379627
r.what --v -f -n input=maps1_ED_rate@PERMANENT east_north=749203.872751,3599819.864513
r.what --v -f -n input=maps1_ED_rate@PERMANENT east_north=746717.529372,3599988.430165
r.what --v -f -n input=nomaps1_ED_rate0009@PERMANENT east_north=754640.115053,3598007.783745
r.what --v -f -n input=nomaps1_ED_rate0009@PERMANENT east_north=754640.115053,3598007.783745
r.what --v -f -n input=nomaps1_ED_rate0009@PERMANENT east_north=755988.640276,3600999.824082
r.what --v -f -n input=nomaps1_ED_rate0009@PERMANENT east_north=754387.266574,3602685.480610
r.what --v -f -n input=nomaps1_ED_rate0009@PERMANENT east_north=750763.105039,3603106.894742
r.what --v -f -n input=maps1_ED_rate0001@PERMANENT east_north=753923.711029,3597586.369613
r.what --v -f -n input=maps1_ED_rate0001@PERMANENT east_north=753080.882765,3601294.813974
r.what --v -f -n input=maps1_ED_rate0001@PERMANENT east_north=751142.377758,3601589.803867
r.what --v -f -n input=maps1_ED_rate0001@PERMANENT east_north=753291.589831,3601842.652346
r.what --v -f -n input=maps1_ED_rate0001@PERMANENT east_north=760750.619967,3597544.228200
r.what --v -f -n input=maps1_ED_rate0001@PERMANENT east_north=763068.397693,3591939.420245
r.what --v -f -n input=maps1_ED_rate0001@PERMANENT east_north=754218.700921,3594973.601995
r.what --v -f -n input=maps1_ED_rate0001@PERMANENT east_north=752069.488848,3596912.107002
r.what --v -f -n input=maps1_ED_rate0001@PERMANENT east_north=748066.054594,3599819.864513
r.colors map=maps1_ED_rate0001@PERMANENT color=differences
r.colors -e map=maps1_ED_rate0001@PERMANENT color=differences
r.what --v -f -n input=maps1_ED_rate0001@PERMANENT east_north=747897.488942,3599482.733207
r.what --v -f -n input=maps1_ED_rate0001@PERMANENT east_north=749330.296990,3599735.581686
r.what --v -f -n input=maps1_ED_rate0001@PERMANENT east_north=751479.509063,3599398.450381
r.what --v -f -n input=maps1_ED_rate0001@PERMANENT east_north=753713.003963,3598639.904943
r.what --v -f -n input=maps1_ED_rate0001@PERMANENT east_north=754513.690814,3599904.147339
r.what --v -f -n input=maps1_ED_rate0001@PERMANENT east_north=758053.569522,3598176.349398
r.what --v -f -n input=maps1_ED_rate0001@PERMANENT east_north=760076.357356,3595605.723193
r.what --v -f -n input=maps1_ED_rate0001@PERMANENT east_north=764121.933023,3593287.945467
r.what --v -f -n input=maps1_ED_rate0001@PERMANENT east_north=751816.640369,3601336.955388
r.what --v -f -n input=maps1_ED_rate0001@PERMANENT east_north=752743.751459,3600325.561471
r.what --v -f -n input=y00003_landcover.Cfactor@temporary_Run1 east_north=751437.367650,3600156.995818
r.what --v -f -n input=y00003_landcover.Cfactor@temporary_Run1 east_north=748824.600032,3600199.137231
r.what --v -f -n input=y00003_landcover.Cfactor@temporary_Run1 east_north=746169.691000,3600156.995818
r.what --v -f -n input=y00003_landcover.Cfactor@temporary_Run1 east_north=743514.781969,3600199.137231
r.what --v -f -n input=y00003_landcover.Cfactor@temporary_Run1 east_north=750299.549494,3600662.692776
r.what --v -f -n input=y00003_landcover.Cfactor@temporary_Run1 east_north=750130.983841,3601168.389735
r.what --v -f -n input=y00003_landcover.Cfactor@temporary_Run1 east_north=750130.983841,3601421.238214
r.what --v -f -n input=y00003_landcover.Cfactor@temporary_Run1 east_north=750847.387865,3599904.147339
r.what --v -f -n input=y00003_landcover.Cfactor@temporary_Run1 east_north=748023.913181,3600030.571578
r.what --v -f -n input=y00003_landcover.Cfactor@temporary_Run1 east_north=747096.802091,3600241.278644
r.what --v -f -n input=y00003_landcover.Cfactor@temporary_Run1 east_north=746338.256653,3600199.137231
r.what --v -f -n input=y00003_landcover.Cfactor@temporary_Run1 east_north=745200.438497,3600283.420058
r.colors map=maps1_ED_rate0005@PERMANENT color=differences
r.colors -e map=maps1_ED_rate0005@PERMANENT color=differences
r.what --v -f -n input=maps1_ED_rate0005@PERMANENT east_north=751395.226237,3601631.945280
r.what --v -f -n input=maps1_ED_rate0005@PERMANENT east_north=749203.872751,3600999.824082
r.what --v -f -n input=maps1_ED_rate0005@PERMANENT east_north=746043.266761,3600156.995818
r.what --v -f -n input=maps1_ED_rate0005@PERMANENT east_north=754935.104946,3597881.359505
r.what --v -f -n input=maps1_ED_rate0005@PERMANENT east_north=747054.660678,3598049.925158
r.what --v -f -n input=maps1_ED_rate0005@PERMANENT east_north=746759.670785,3598387.056464
r.what --v -f -n input=maps1_ED_rate0005@PERMANENT east_north=746591.105132,3598850.612009
r.what --v -f -n input=maps1_ED_rate0005@PERMANENT east_north=754682.256466,3599314.167554
r.what --v -f -n input=maps1_ED_rate0005@PERMANENT east_north=754682.256466,3599651.298860
r.what --v -f -n input=maps1_ED_rate0005@PERMANENT east_north=754892.963532,3599735.581686
r.what --v -f -n input=maps1_ED_rate0005@PERMANENT east_north=755988.640276,3599693.440273
r.what --v -f -n input=maps1_ED_rate0005@PERMANENT east_north=755230.094838,3598977.036249
r.what --v -f -n input=maps1_ED_rate0005@PERMANENT east_north=755103.670598,3599145.601901
r.what --v -f -n input=maps1_ED_rate0005@PERMANENT east_north=754176.559508,3600114.854405
g.mremove -f rast=maps1*
g.mremove -f rast=maps1*
g.mremove -f rast=maps1*
g.mremove -f rast=maps1*
g.mremove -f rast=nomaps1*
g.mremove -f rast=nomaps1*
g.mremove -f rast=test1*
g.mremove -f rast=maps1*
r.landscape.evol&
/home/medland/APSIM/Scripts/r.landscape.evol.py&
/home/medland/APSIM/Scripts/r.landscape.evol.py&
/home/medland/APSIM/Scripts/r.cfactor.py&
/home/medland/APSIM/Scripts/r.cfactor.py&
/home/medland/APSIM/Scripts/r.cfactor.py&
/home/medland/APSIM/Scripts/r.cfactor.py&
/home/medland/APSIM/Scripts/r.landscape.evol.py&
/home/medland/APSIM/Scripts/r.land.assess.py&
/home/medland/APSIM/Scripts/r.soildepth.py&
whereis r.soildepth.py
exit
g.region -s -p res=10
r.mapcalc DEM = PaleoDEM@PERMANENT
r.info map=DEM@PERMANENT
r.mapcalc Landcover = Init_Landcover@PERMANENT
r.mapcalc BDRK = PaleoBDRK@PERMANENT
r.mapcalc Fertility = fertility@PERMANENT
r.mapcalc Friction = friction@PERMANENT
g.remove rast=Init_Landcover@PERMANENT,Init_Landcover.C_factor@PERMANENT,PaleoBDRK@PERMANENT,PaleoDEM@PERMANENT,PaleoSDEPTH_init@PERMANENT,fertility@PERMANENT,friction@PERMANENT
r.mapcalc Kfactor = Init_Kfactor@PERMANENT
r.info map=Kfactor@PERMANENT
g.remove rast=Landcover@PERMANENT
g.rename rast=Landcover1@PERMANENT,Landcover
exit
g.region -p
g.region -p res=10
r.mapcalc MASK = if(isnull(DEM@PERMANENT),null(),1)
v.to.rast input=wadi_cutouts_all_patched_vect@PERMANENT output=wadi_cutouts_all_patched use=val
r.mapcalc wadi_cutouts_all_patched_inverse = if(isnull(wadi_cutouts_all_patched@PERMANENT),1,null())
r.to.vect input=wadi_cutouts_all_patched_inverse@PERMANENT output=wadi_cutouts_all_patched_inverse_vect feature=area
v.select ainput=random_points_100p@PERMANENT atype=point binput=wadi_cutouts_all_patched_inverse_vect@PERMANENT btype=boundary,centroid,area output=random_points_100p_wadi_cutouts
v.build map=random_points_100p@PERMANENT
v.select ainput=random_points_100p@PERMANENT atype=point binput=wadi_cutouts_all_patched_inverse_vect@PERMANENT btype=boundary,centroid,area output=random_points_100p_wadi_cutouts
v.surf.rst -z input=random_points_100p_wadi_cutouts@PERMANENT elev=Paleo_DEM_10m maskmap=MASK@PERMANENT tension=30. smooth=4 dmin=30.000707 dmax=60.003535
r.mapcalc AAA_DIF = Paleo_DEM_10m@PERMANENT-DEM@PERMANENT
r.colors map=AAA_DIF@PERMANENT color=differences
r.what --v -f -n input=AAA_DIF@PERMANENT east_north=748529.610140,3603696.874527
r.what --v -f -n input=AAA_DIF@PERMANENT east_north=750130.983841,3601168.389735
r.what --v -f -n input=AAA_DIF@PERMANENT east_north=751858.781782,3601126.248322
r.what --v -f -n input=AAA_DIF@PERMANENT east_north=755440.801904,3598218.490811
v.surf.rst -z input=random_points_100p@PERMANENT elev=ASTER_DEM_10m maskmap=MASK@PERMANENT smooth=2 dmin=30.000707 dmax=60.003535
r.random input=Landcover@PERMANENT n=75% vector_output=Landcover_points_75p
r.mapcalc AAA_DIF = Paleo_DEM_10m@PERMANENT-ASTER_DEM_10m@PERMANENT
r.colors map=AAA_DIF@PERMANENT color=differences
r.what --v -f -n input=AAA_DIF@PERMANENT east_north=749215.258048,3600894.707743
r.what --v -f -n input=AAA_DIF@PERMANENT east_north=749036.493066,3600873.676568
r.what --v -f -n input=AAA_DIF@PERMANENT east_north=748668.447516,3600810.583045
r.what --v -f -n input=AAA_DIF@PERMANENT east_north=748531.744883,3600547.693367
r.what --v -f -n input=AAA_DIF@PERMANENT east_north=748678.963103,3600400.475146
r.what --v -f -n input=AAA_DIF@PERMANENT east_north=748763.087800,3600253.256926
r.what --v -f -n input=AAA_DIF@PERMANENT east_north=751717.967792,3601714.923541
r.what --v -f -n input=AAA_DIF@PERMANENT east_north=747532.764103,3601388.940339
r.what --v -f -n input=AAA_DIF@PERMANENT east_north=747438.123818,3603407.933074
r.what --v -f -n input=AAA_DIF@PERMANENT east_north=747795.653782,3599180.667036
r.what --v -f -n input=AAA_DIF@PERMANENT east_north=749036.493066,3600116.554293
r.what --v -f -n input=AAA_DIF@PERMANENT east_north=749646.397122,3599674.899632
v.perturb input=Landcover_points_75p@PERMANENT output=Landcover_points_75p_perturbed distribution=normal parameters=0,50 seed=5476
g.region -p
v.surf.idw input=Landcover_points_75p_perturbed@PERMANENT output=Landcover_perturbed
v.surf.idw input=Landcover_points_75p_perturbed@PERMANENT output=Landcover_perturbed column=value
r.what --v -f -n input=Landcover_perturbed@PERMANENT east_north=747926.898015,3603223.109911
r.what --v -f -n input=Landcover_perturbed@PERMANENT east_north=747838.599433,3603031.796318
r.what --v -f -n input=Landcover_perturbed@PERMANENT east_north=747722.339635,3603028.853032
r.what --v -f -n input=Landcover_perturbed@PERMANENT east_north=747943.086088,3602844.897654
v.perturb --overwrite input=Landcover_points_75p@PERMANENT output=Landcover_points_75p_perturbed distribution=normal parameters=0,100 minimum=10 seed=5476
v.to.rast input=Landcover_points_75p_perturbed@PERMANENT output=Landcover_points_75p_perturbed use=attr column=value
r.bilinear --overwrite input=Landcover_points_75p_perturbed@PERMANENT output=Landcover_perturbed
v.surf.bspline input=Landcover_points_75p_perturbed@PERMANENT raster=Landcover_perturbed sie=60 sin=60 column=value
v.surf.bspline --overwrite input=Landcover_points_75p_perturbed@PERMANENT raster=Landcover_perturbed sie=60 sin=60 column=value
db.columns table=Landcover_points_75p_perturbed
v.surf.bspline --overwrite input=Landcover_points_75p_perturbed@PERMANENT raster=Landcover_perturbed sie=60 sin=60 column=value
v.surf.bspline --overwrite input=Landcover_points_75p_perturbed@PERMANENT raster=Landcover_perturbed sie=60 sin=60 layer=1 column=value
r.colors map=Landcover_perturbed@PERMANENT rules=/home/medland/SAA2012/APSIM/Rules/luse_colors.txt
r.what --v -f -n input=Landcover_perturbed@PERMANENT east_north=751058.094931,3601505.521040
r.what --v -f -n input=Landcover_perturbed@PERMANENT east_north=742503.388052,3601336.955388
r.surf.idw2 --overwrite input=Landcover_points_75p_perturbed@PERMANENT output=Landcover_perturbed
v.surf.idw input=Landcover_points_75p_perturbed@PERMANENT output=Landcover_perturbed column=value
v.surf.idw --overwrite input=Landcover_points_75p_perturbed@PERMANENT output=Landcover_perturbed column=value
r.what --v -f -n input=Landcover_perturbed@PERMANENT east_north=752364.478741,3601758.369520
r.what --v -f -n input=Landcover_perturbed@PERMANENT east_north=752238.054501,3602011.217999
r.what --v -f -n input=Landcover_perturbed@PERMANENT east_north=752195.913088,3602264.066478
r.what --v -f -n input=Landcover_perturbed@PERMANENT east_north=752195.913088,3602264.066478
r.what --v -f -n input=Landcover_perturbed@PERMANENT east_north=748441.492682,3603113.615230
r.colors map=Landcover_perturbed@PERMANENT rules=/home/medland/SAA2012/APSIM/Rules/luse_colors.txt
r.what --v -f -n input=Landcover_perturbed@PERMANENT east_north=748441.492682,3603102.229933
r.what --v -f -n input=Landcover_perturbed@PERMANENT east_north=747843.764570,3602846.060742
r.what --v -f -n input=Landcover_perturbed@PERMANENT east_north=747866.535164,3602794.826903
r.what --v -f -n input=Landcover_perturbed@PERMANENT east_north=747570.517433,3603227.468204
r.what --v -f -n input=Landcover_perturbed@PERMANENT east_north=748442.032041,3603230.640280
r.colors map=Landcover_perturbed@PERMANENT rules=/home/medland/SAA2012/APSIM/Rules/luse_colors.txt
r.what --v -f -n input=Landcover_perturbed@PERMANENT east_north=748368.166454,3603315.869804
r.what --v -f -n input=Landcover_perturbed@PERMANENT east_north=748328.392676,3603305.317578
r.what --v -f -n input=Landcover_perturbed@PERMANENT east_north=748442.032041,3603233.075409
r.what --v -f -n input=Landcover_perturbed@PERMANENT east_north=748415.245620,3603223.334892
r.what --v -f -n input=Landcover_perturbed@PERMANENT east_north=748428.232976,3603223.334892
r.what --v -f -n input=Landcover_perturbed@PERMANENT east_north=748415.245620,3603233.887119
r.what --v -f -n input=Landcover_perturbed@PERMANENT east_north=748441.220332,3603105.636977
r.what --v -f -n input=Landcover_perturbed@PERMANENT east_north=748433.103234,3603092.649621
r.what --v -f -n input=Landcover_perturbed@PERMANENT east_north=746544.737503,3602995.805630
r.what --v -f -n input=Landcover_perturbed@PERMANENT east_north=746397.182182,3603033.479329
r.what --v -f -n input=Landcover_perturbed@PERMANENT east_north=746340.671634,3602857.668734
r.what --v -f -n input=Landcover_perturbed@PERMANENT east_north=746751.942847,3602659.881815
r.what --v -f -n input=Landcover_perturbed@PERMANENT east_north=746814.732345,3602710.113413
r.what --v -f -n input=Landcover_perturbed@PERMANENT east_north=746924.613967,3602688.137089
g.rename rast=Landcover@PERMANENT,Landcover_init
r.mapcalc Landcover = int(Landcover_perturbed@PERMANENT)
r.colors map=Landcover@PERMANENT rules=/home/medland/SAA2012/APSIM/Rules/luse_colors.txt
r.what --v -f -n input=Landcover@PERMANENT east_north=746462.541510,3603281.381705
r.what --v -f -n input=Landcover@PERMANENT east_north=746488.130849,3603251.527475
r.what --v -f -n input=Landcover@PERMANENT east_north=746904.668435,3602854.892709
r.what --v -f -n input=Landcover@PERMANENT east_north=746995.652754,3602822.195219
r.what --v -f -n input=Landcover@PERMANENT east_north=747531.287907,3603083.306410
r.what --v -f -n input=Landcover@PERMANENT east_north=747524.097344,3603083.306410
r.what --v -f -n input=Landcover@PERMANENT east_north=747660.718046,3603032.972467
r.what --v -f -n input=Landcover@PERMANENT east_north=747689.480299,3602968.257398
r.what --v -f -n input=Landcover@PERMANENT east_north=747754.195368,3602932.304582
r.what --v -f -n input=Landcover@PERMANENT east_north=747876.434944,3602896.351765
r.what --v -f -n input=Landcover@PERMANENT east_north=747948.340576,3602878.375357
r.what --v -f -n input=Landcover@PERMANENT east_north=747998.674519,3602917.923455
r.what --v -f -n input=Landcover@PERMANENT east_north=748741.888415,3602788.164413
r.what --v -f -n input=Landcover@PERMANENT east_north=748543.977802,3602922.743630
r.what --v -f -n input=Landcover@PERMANENT east_north=748369.816462,3602938.576479
r.what --v -f -n input=Landcover@PERMANENT east_north=748290.652216,3602930.660055
r.what --v -f -n input=Landcover@PERMANENT east_north=748251.070094,3603088.988545
r.what --v -f -n input=Landcover@PERMANENT east_north=748631.058471,3603112.737819
r.what --v -f -n input=Landcover@PERMANENT east_north=748900.216906,3603033.573574
r.what --v -f -n input=Landcover@PERMANENT east_north=749153.542491,3602954.409328
r.what --v -f -n input=Landcover@PERMANENT east_north=749216.873887,3602780.247988
r.what --v -f -n input=Landcover@PERMANENT east_north=750261.841926,3601576.951459
r.what --v -f -n input=Landcover@PERMANENT east_north=750404.337567,3601735.279950
r.what --v -f -n input=Landcover@PERMANENT east_north=750420.170416,3601149.464534
r.what --v -f -n input=Landcover@PERMANENT east_north=744813.456984,3600927.875330
r.what --v -f -n input=Landcover@PERMANENT east_north=744139.194373,3600401.621585
r.what --v -f -n input=Landcover@PERMANENT east_north=744254.312379,3599661.577255
r.what --v -f -n input=Landcover@PERMANENT east_north=751046.274779,3599349.114094
r.what --v -f -n input=Landcover@PERMANENT east_north=752773.044881,3600039.822135
r.what --v -f -n input=Landcover@PERMANENT east_north=753661.098076,3600746.975605
r.what --v -f -n input=Landcover@PERMANENT east_north=753644.652647,3598987.314644
r.what --v -f -n input=Landcover@PERMANENT east_north=753809.106942,3601799.483096
r.what --v -f -n input=Landcover@PERMANENT east_north=753496.643781,3602523.081995
r.resamp.stats input=Init_Kfactor@PERMANENT output=Kfactor method=median
r.resamp.stats --overwrite input=Init_Kfactor@PERMANENT output=Kfactor method=median
r.resamp.stats --overwrite input=Init_Kfactor@PERMANENT output=Kfactor
r.resample --overwrite input=Init_Kfactor@PERMANENT output=Kfactor
r.random input=Kfactor@PERMANENT n=25% vector_output=K_fact_points_rand25p
v.perturb input=K_fact_points_rand25p@PERMANENT output=K_fact_points_rand25p_perturbed distribution=normal parameters=0,50 minimum=5 seed=2411
v.surf.idw input=K_fact_points_rand25p_perturbed@PERMANENT output=K_factor
v.surf.idw input=K_fact_points_rand25p_perturbed@PERMANENT output=K_factor column=value
r.what --v -f -n input=K_factor@PERMANENT east_north=746928.236438,3604118.288659
r.neighbors input=K_factor@PERMANENT output=K_factor2 method=median size=7
r.neighbors --overwrite input=K_factor@PERMANENT output=K_factor2 method=median size=15
r.neighbors --overwrite input=K_factor@PERMANENT output=K_factor2 method=median size=3
r.neighbors --overwrite input=K_factor@PERMANENT output=K_factor2 method=median size=5
r.info map=Friction@PERMANENT
g.remove rast=MASK@PERMANENT,AAA_DIF@PERMANENT,Init_Kfactor@PERMANENT,K_factor@PERMANENT,Landcover_points_75p_perturbed@PERMANENT vect=Landcover_points_75p@PERMANENT,K_fact_points_rand25p@PERMANENT,K_fact_points_rand25p_perturbed@PERMANENT,Landcover_points_75p_perturbed@PERMANENT
g.gui&
exit
nviz elevation=DEM@PERMANENT
nviz elevation=DEM@PERMANENT,Paleo_DEM_10m@PERMANENT
nviz elevation=Paleo_DEM_10m@PERMANENT
exit
g.remove rast=DEM@PERMANENT,BDRK@PERMANENT,Landcover_perturbed@PERMANENT
g.rename rast=Initial_landcover_map_holes_filled_sharp_boundaries@PERMANENT
g.rename rast=Landcover_init@PERMANENT,landcover_map_holes_filled_sharp_boundaries
g.rename rast=Paleo_DEM_10m@PERMANENT,PaleoDEM10m
g.remove rast=Kfactor@PERMANENT
g.rename rast=K_factor2@PERMANENT,Kfactor
g.rename rast=K_factor2@PERMANENT,K_factor
r.info map=Friction@PERMANENT
r.info map=Fertility@PERMANENT
r.soildepth.py elev=PaleoDEM10m@PERMANENT bedrock=PaleoBDRK10m soildepth=init_sdepth min=0.0001 max=20.0 slopebreaks=15,0.5;45,0.15 curvebreaks=-0.015,-0.5;0.015,0.5 smoothingtype=median smoothingsize=3
r.cfactor.py inmap=Landcover@PERMANENT outcfact=Landcover_cfactor_init cfact_rules=/home/medland/SAA2012/APSIM/Rules/cfactor_recode_rules.txt cfact_color=/home/medland/SAA2012/APSIM/Rules/cfactor_colors.txt
r.what --v -f -n input=Landcover_cfactor_init@PERMANENT east_north=755145.812012,3601969.076586
r.what --v -f -n input=Landcover_cfactor_init@PERMANENT east_north=755187.953425,3601884.793759
r.what --v -f -n input=Landcover_cfactor_init@PERMANENT east_north=754935.104946,3601926.935172
r.what --v -f -n input=Landcover_cfactor_init@PERMANENT east_north=754640.115053,3601842.652346
r.what --v -f -n input=Landcover_cfactor_init@PERMANENT east_north=754387.266574,3601800.510933
r.what --v -f -n input=Landcover_cfactor_init@PERMANENT east_north=754134.418095,3601547.662454
r.what --v -f -n input=Landcover_cfactor_init@PERMANENT east_north=753080.882765,3601126.248322
r.what --v -f -n input=Landcover_cfactor_init@PERMANENT east_north=753123.024178,3599693.440273
r.what --v -f -n input=Landcover_cfactor_init@PERMANENT east_north=753291.589831,3599609.157447
r.what --v -f -n input=Landcover_cfactor_init@PERMANENT east_north=754724.397880,3599061.319075
r.what --v -f -n input=Landcover_cfactor_init@PERMANENT east_north=754724.397880,3599061.319075
r.what --v -f -n input=Landcover_cfactor_init@PERMANENT east_north=756705.044300,3598176.349398
r.what --v -f -n input=Landcover_cfactor_init@PERMANENT east_north=757000.034192,3597586.369613
r.what --v -f -n input=Landcover_cfactor_init@PERMANENT east_north=757000.034192,3597586.369613
r.what --v -f -n input=Landcover_cfactor_init@PERMANENT east_north=757000.034192,3597333.521134
r.what --v -f -n input=Landcover_cfactor_init@PERMANENT east_north=753782.857506,3601049.239435
r.what --v -f -n input=Landcover_cfactor_init@PERMANENT east_north=753798.512290,3601016.506705
r.what --v -f -n input=Landcover_cfactor_init@PERMANENT east_north=754245.385212,3600894.114759
r.what --v -f -n input=Landcover_cfactor_init@PERMANENT east_north=754283.810591,3600894.114759
r.landscape.evol.py -p elev=PaleoDEM10m@PERMANENT initbdrk=PaleoBDRK10m@PERMANENT K=K_factor@PERMANENT Kt=0.0001 loadexp=1.5 kappa=1 C=Landcover_cfactor_init@PERMANENT R=8.78 storms=99 stormlength=12 speed=1.4 cutoff1=0.65 cutoff2=2.25 cutoff3=7 smoothing=no prefx=levol_ outdem=elevation outsoil=soildepth number=1
g.copy rast=y00299_Landcover@greedagr_Run1,greedagr_y299_lcov
g.copy rast=y00299_PaleoDEM10m@greedagr_Run1,greedagr_y299_dem
g.copy rast=y00299_fertility@greedagr_Run1,greedagr_y299_fertiltiy
g.gui&
exit
v.in.ogr dsn=/Users/iullah/Desktop/GIS_Data/WT-4_terrace.shp layer=WT-4_terrace output=WT_4_terrace
v.in.ogr dsn=/Users/iullah/Desktop/GIS_Data/WT-4_terrace.shp layer=WT-4_terrace output=WT_4_terrace -o
v.in.ogr dsn=/Users/iullah/Desktop/GIS_Data/WT-4_terrace.shp layer=WT-4_terrace output=WT_4_terrace --overwrite
v.in.ogr dsn=/Users/iullah/Desktop/GIS_Data/WT-4_terrace.shp layer=WT-4_terrace output=WT_4_terrace --overwrite
v.to.rast input=WT_4_terrace@PERMANENT output=WT_4_terrace use=val
r.stats -a input=WT_4_terrace@PERMANENT
r.slope.aspect elevation=ASTER_DEM_10m@PERMANENT slope=ASTER_10m_slope
r.mapcalc ASTER_10m_local_rise = 10*tan(ASTER_10m_slope@PERMANENT)
r.what --v -f -n input=ASTER_10m_local_rise@PERMANENT east_north=755898.548482,3598708.133898
r.what --v -f -n input=ASTER_10m_local_rise@PERMANENT east_north=756082.851154,3599113.599776
r.what --v -f -n input=ASTER_10m_local_rise@PERMANENT east_north=757225.527719,3598818.715501
r.watershed -f -a elevation=ASTER_DEM_10m@PERMANENT stream=ASTER_10m_streams threshold=100000
r.cost -k input=ASTER_10m_local_rise@PERMANENT output=ASTER_10m_rise_cost start_rast=ASTER_10m_streams@PERMANENT
r.colors -g map=ASTER_10m_rise_cost@PERMANENT
r.colors -g map=ASTER_10m_rise_cost@PERMANENT color=bcyr
r.colors map=ASTER_10m_rise_cost@PERMANENT color=bcyr
r.colors -n -e map=ASTER_10m_rise_cost@PERMANENT color=bgyr
nviz elevation=ASTER_DEM_10m@PERMANENT color=ASTER_10m_rise_cost@PERMANENT
r.what --v -f -n input=ASTER_10m_rise_cost@PERMANENT east_north=748224.454493,3601277.650790
r.what --v -f -n input=ASTER_10m_rise_cost@PERMANENT east_north=748224.454493,3601277.650790
r.mapcalc ASTER_10m_rise_cost_cutoff = if(ASTER_10m_rise_cost@PERMANENT>=17.44,ASTER_10m_rise_cost@PERMANENT,null())
nviz elevation=ASTER_DEM_10m@PERMANENT color=ASTER_10m_rise_cost_cutoff@PERMANENT
g.remove rast=greedagr_y299_dem@PERMANENT,WT_4_terrace@PERMANENT,greedagr_y299_fertiltiy@PERMANENT,greedagr_y299_lcov@PERMANENT,init_sdepth@PERMANENT,landcover_map_holes_filled_sharp_boundaries@PERMANENT,levol_flowdir0001@PERMANENT,levol_soildepth_init@PERMANENT,wadi_cutouts_all_patched@PERMANENT,wadi_cutouts_all_patched_inverse@PERMANENT vect=WT_4_terrace@PERMANENT,WZ_Middle_Terraces@PERMANENT,Ziqlab_Neolithic_Sites@PERMANENT,levol_1459_randomly_sampled_points@PERMANENT,random_points_100p@PERMANENT,random_points_100p_wadi_cutouts@PERMANENT,wadi_cutouts_all_patched_inverse_vect@PERMANENT,wadi_cutouts_all_patched_vect@PERMANENT,ziqlab_sites_terraces@PERMANENT
g.remove rast=Landcover_cfactor_init@PERMANENT,ASTER_DEM_10m@PERMANENT,ASTER_10m_streams@PERMANENT,ASTER_10m_slope@PERMANENT,ASTER_10m_rise_cost_cutoff@PERMANENT
r.info map=ASTER_10m_local_rise@PERMANENT
g.remove rast=Landcover_cfactor_init@PERMANENT,ASTER_DEM_10m@PERMANENT,ASTER_10m_streams@PERMANENT,ASTER_10m_slope@PERMANENT,ASTER_10m_rise_cost_cutoff@PERMANENT,ASTER_10m_local_rise@PERMANENT,ASTER_10m_rise_cost@PERMANENT
exit
