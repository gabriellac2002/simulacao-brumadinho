*KEYWORD
*TITLE
3D dam break - SPH water coupled to deformable solid gate - pressure histories
$ Units: kg, m, s, N, Pa. SPH pressure histories are written to sphout.
*CONTROL_BULK_VISCOSITY
$#      q1        q2      type     btype
     0.0011.0000E-12         1         0
*CONTROL_SPH
$#    ncbs     boxid        dt      idim    memory      form     start      maxv
         1         11.00000E20         3       500        15       0.0      20.0
$#    cont     deriv       ini     ishow     ierod     icont     iavis     isymp
         0         0         0         1         0         0         1       100
$#    ithk
         0
*DEFINE_BOX
$#   boxid       xmn       xmx       ymn       ymx       zmn       zmx
         1     -0.16      0.11     -0.01      0.21     -0.01      0.06
*CONTROL_TERMINATION
$#  endtim    endcyc     dtmin    endeng    endmas     nosol
       0.2         0       0.0       0.0       0.0         0
*CONTROL_TIMESTEP
$#  dtinit    tssfac      isdo    tslimt     dt2ms      lctm     erode     ms1st
       0.0      0.45         0       0.0       0.0         0         0         0
*DATABASE_BINARY_D3PLOT
$#      dt      lcdt      beam     npltc    psetid
     0.005         0         0         0         0
*DATABASE_NODOUT
     0.002         0         0         1       0.0         0
*DATABASE_GLSTAT
     0.002         0         0         1
*DATABASE_MATSUM
     0.002         0         0         1
$--- SPH histories for pressure comparison with the 2D reference.
$--- Four heights beside the gate; five particles through Z are averaged per height.
*DATABASE_HISTORY_SPH
$#     nid1      nid2      nid3      nid4      nid5      nid6      nid7      nid8
$--- Low level: y approximately 0.015 m
     20677     22469     22510     22514     21546
*DATABASE_HISTORY_SPH
$#     nid1      nid2      nid3      nid4      nid5      nid6      nid7      nid8
$--- Mid-low level: y approximately 0.045 m
     22504     22639     22496     22788     22723
*DATABASE_HISTORY_SPH
$#     nid1      nid2      nid3      nid4      nid5      nid6      nid7      nid8
$--- Mid-high level: y approximately 0.075 m
     22578     22632     22641     22828     21418
*DATABASE_HISTORY_SPH
$#     nid1      nid2      nid3      nid4      nid5      nid6      nid7      nid8
$--- High level: y approximately 0.105 m
     20251     22663     22700     22769     22706
*DATABASE_SPHOUT
     0.002
$--- Solid gate
*PART
Deformable gate - 3D solids, 10 layers through Z
$#     pid     secid       mid     eosid      hgid      grav    adpopt      tmid
         1         1         1         0         0         0         0         0
*SECTION_SOLID
$#   secid    elform       aet
         1         1         0
*MAT_MOONEY-RIVLIN_RUBBER
$#     mid        ro        pr         n
         1    1100.0       0.4         2
$#     sgl        sw        st      lcid
         1         1         1         7
*DEFINE_CURVE
$#    lcid      sidr       sfa       sfo      offa      offo    dattyp     lcint
         7         0       1.0       1.0       0.0       0.0         0         0
       0.0,       0.0
     0.001,   10000.0
0.00395534,   56916.5
 0.00889952,  86812.9
 0.0197767,  135734.0
 0.0385646,  217270.0
 0.0791069,  350445.0
  0.199745,  652127.0
  0.403445, 1.00545e6
$--- SPH water
*PART
SPH water, initial reservoir
$#     pid     secid       mid     eosid      hgid      grav    adpopt      tmid
        10        10        10        10         0         0         0         0
*SECTION_SPH
$#   secid      cslh      hmin      hmax    sphini     death     start
        10       1.2       1.0       1.0       0.0 1.00000E20       0.0
*MAT_NULL
$#     mid        ro        pc        mu     terod     cerod        ym        pr
        10    1000.0  -50000.0     0.001       0.0       0.0       0.0       0.0
*EOS_MURNAGHAN
$#   eosid     gamma        k0        v0
        10       7.0 150000.0       0.0
$--- Fixed walls: rear, bottom, front/back and wall above the gate opening
*PART
Fixed channel walls
$#     pid     secid       mid     eosid      hgid      grav    adpopt      tmid
        20        20        20         0         0         0         0         0
*SECTION_SHELL
$#   secid    elform      shrf       nip     propt      qr/irid
        20         2       1.0         2
$#      t1        t2        t3        t4      nloc      marea      idof
     0.002     0.002     0.002     0.002
*MAT_RIGID
$#     mid        ro         e        pr         n    couple         m     alias
        20    1000.0     1.0e9       0.3       0.0       0.0       0.0
$#     cmo      con1      con2
       1.0         7         7
$#lco or a1        a2        a3        v1        v2        v3
       0.0       0.0       0.0       0.0       0.0       0.0
$--- Gravity direction follows the original DAM5 coordinate convention
*LOAD_BODY_Y
$#    lcid        sf
         1       9.81
*DEFINE_CURVE
$#    lcid      sidr       sfa       sfo      offa      offo    dattyp     lcint
         1         0       1.0       1.0       0.0       0.0         0         0
       0.0,       0.0
     0.005,       1.0
       1.0,       1.0
$--- FSI contact: SPH particles are slave, gate and walls are master surfaces
*CONTACT_AUTOMATIC_NODES_TO_SURFACE_ID
         1SPH water to deformable gate
$#    ssid      msid     sstyp     mstyp    sboxid    mboxid       spr       mpr
        10         1         3         3         0         0         0         0
$#      fs        fd        dc        vc       vdc    penchk        bt        dt
       0.0       0.0       0.0       0.0       0.0         0       0.0 1.00000E20
$#     sfs       sfm       sst       mst      sfst      sfmt       fsf       vsf
       0.0       0.5       0.0       0.0       1.0       1.0       1.0       1.0
$#    soft    sofscl    lcidab    maxpar     sbopt     depth     bsort    frcfrq
         1       0.1         0     1.025       2.0         2        50         1
*CONTACT_AUTOMATIC_NODES_TO_SURFACE_ID
         2SPH water to fixed channel walls
$#    ssid      msid     sstyp     mstyp    sboxid    mboxid       spr       mpr
        10        20         3         3         0         0         0         0
$#      fs        fd        dc        vc       vdc    penchk        bt        dt
       0.0       0.0       0.0       0.0       0.0         0       0.0 1.00000E20
$#     sfs       sfm       sst       mst      sfst      sfmt       fsf       vsf
       0.0       0.5       0.0       0.0       1.0       1.0       1.0       1.0
$#    soft    sofscl    lcidab    maxpar     sbopt     depth     bsort    frcfrq
         1       0.1         0     1.025       2.0         2        50         1
*INCLUDE
mesh_struc_3D_refinedZ.k
*INCLUDE
mesh_sph_container_3d.k
*INCLUDE
water_sph_volume.k
*END
