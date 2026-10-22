$-----------------------------------------------------------------------------
$
$ Example provided by Iaki (LSTC)
$
$ E-Mail: info@dynamore.de
$ Web: http://www.dynamore.de
$
$ Copyright, 2015 DYNAmore GmbH
$ Copying for non-commercial usage allowed if
$ copy bears this notice completely.
$
$X------------------------------------------------------------------------------
$X
$X 1. Run file as is.
$X    Requires LS-DYNA MPP R9 (or higher) with double precision 
$X
$X------------------------------------------------------------------------------
$# UNITS: (kg/m/s) 
$X------------------------------------------------------------------------------
$X
*KEYWORD
*TITLE
ICFD Dam break - elastic gate removed at t=0 (open)
$---+----1----+----2----+----3----+----4----+----5----+----6----+----7----+----8
$                                                                              $
$                             PARAMETERS                                       $
$                                                                              $
$---+----1----+----2----+----3----+----4----+----5----+----6----+----7----+----8
*PARAMETER
R    T_end       0.4
R  dt_plot      5e-3
$
$--- Fluid
$
Rrho_fluid      1000
R mu_fluid     0.001 
R dt_fluid      5e-4
R  grav         9.81
R  fsi_bt       1e-3
*INCLUDE
mesh_3D_open.k
*CONTROL_TERMINATION
$#  endtim
    &T_end
$
$---+----1----+----2----+----3----+----4----+----5----+----6----+----7----+----8
$                                                                              $
$                           ICFD CONTROL CARDS                                 $
$                                                                              $
$---+----1----+----2----+----3----+----4----+----5----+----6----+----7----+----8
*ICFD_CONTROL_TIME
$#     ttm        dt
    &T_end &dt_fluid
*ICFD_CONTROL_FSI
$#     owc        bt
         0   &fsi_bt
*ICFD_CONTROL_OUTPUT
$#   msglv
         3
*ICFD_CONTROL_ADAPT_SIZE
$#   asize
         1
$---+----1----+----2----+----3----+----4----+----5----+----6----+----7----+----8
$                                                                              $
$                       ICFD PARTS/ SECTION/ MATERIAL                          $
$                                                                              $
$---+----1----+----2----+----3----+----4----+----5----+----6----+----7----+----8
*ICFD_SECTION
$#     sid   
         1
*ICFD_MAT
$#     mid       flg        ro       vis          
         1         1&rho_fluid &mu_fluid 
*ICFD_MAT
$#     mid       flg        ro       vis          
         2         0        
*ICFD_PART
$#     pid     secid       mid 
         1         1         1
*ICFD_PART
$#     pid     secid       mid 
         3         1         1
*ICFD_PART
$#     pid     secid       mid 
         4         1         1
*ICFD_PART
$#     pid     secid       mid 
         5         1         1
*ICFD_PART
$#     pid     secid       mid 
         6         1         2
*ICFD_PART
$#     pid     secid       mid 
         7         1         2
*ICFD_PART
$#     pid     secid       mid 
         8         1         2
*ICFD_PART
$#     pid     secid       mid 
         9         1         2
*ICFD_PART
$#     pid     secid       mid 
        10         1         2
*ICFD_PART
$#     pid     secid       mid 
        12         1         2
*ICFD_PART
$#     pid     secid       mid 
        13         1         2
*ICFD_PART
$#     pid     secid       mid 
        14         1         2
*ICFD_PART
$# Front/back cap for volume 15 (water)
$#     pid     secid       mid
        17         1         1
*ICFD_PART
$# Front/back cap for volume 16 (air)
$#     pid     secid       mid
        18         1         2
*ICFD_PART_VOL
$#     pid     secid       mid 
        15         1         1
$#   spid1     spid2     spid3     spid4     spid5     spid6     spid7     spid8
         1         4         5         6        17
*ICFD_PART_VOL
$#     pid     secid       mid 
        16         1         2
$#   spid1     spid2     spid3     spid4     spid5     spid6     spid7     spid8
         3         4         6         7         8         9        10        12
$#   spid9    spid10    spid11    spid12    
        13        14        18
$---+----1----+----2----+----3----+----4----+----5----+----6----+----7----+----8
$                                                                              $
$                    ICFD BOUNDARY/INITIAL CONDITIONS                          $
$                                                                              $
$---+----1----+----2----+----3----+----4----+----5----+----6----+----7----+----8
*ICFD_BOUNDARY_FREESLIP
$#     pid   
         1
*ICFD_BOUNDARY_NONSLIP
$#     pid   
         3
*ICFD_BOUNDARY_FREESLIP
$#     pid   
         5
*ICFD_BOUNDARY_FREESLIP
$#     pid   
         7
*ICFD_BOUNDARY_FREESLIP
$#     pid   
         8
*ICFD_BOUNDARY_PRESCRIBED_PRE
$#     pid      lcid        sf     death     birth     
         9         2 
*ICFD_BOUNDARY_FREESLIP
$#     pid   
        10
*ICFD_BOUNDARY_FREESLIP
$#     pid   
        12
*ICFD_BOUNDARY_FREESLIP
$#     pid   
        13
*ICFD_BOUNDARY_FREESLIP
$#     pid   
        14
*ICFD_BOUNDARY_FREESLIP
$# Front/back walls of water volume
$#     pid
        17
*ICFD_BOUNDARY_FREESLIP
$# Front/back walls of air volume
$#     pid
        18
*LOAD_BODY_Y
$#    lcid        sf       
         1        1          
*DEFINE_CURVE_TITLE
Gravity force
$#    lcid      sidr       sfa       sfo      offa      offo    dattyp
         1                    &grav
$#                a1                  o1
                 0.0                 1.0
             10000.0                 1.0
*DEFINE_CURVE_TITLE
Pressure outlet
$#    lcid      sidr       sfa       sfo      offa      offo    dattyp
         2
$#                a1                  o1
                 0.0                 0.0
             10000.0                 0.0
$---+----1----+----2----+----3----+----4----+----5----+----6----+----7----+----8
$                                                                              $
$                            ICFD MESH KEYWORDS                                $
$                                                                              $
$---+----1----+----2----+----3----+----4----+----5----+----6----+----7----+----8
*MESH_VOLUME
$#   volid     
        30
$#    pid1      pid2      pid3      pid4      pid5      pid6      pid7      pid8    
         1         3         5         7         8         9        10        12
$#    pid9     pid10     pid11     pid12     pid13     pid14
        13        14        17        18
*MESH_INTERF
$#     pid     
        30
$#   spid1
         4
*MESH_INTERF
$#     pid     
        30
$#   spid1
         6
$---+----1----+----2----+----3----+----4----+----5----+----6----+----7----+----8
$                                                                              $
$                             DATABASE (OUTPUT)                                $
$                                                                              $
$---+----1----+----2----+----3----+----4----+----5----+----6----+----7----+----8
*ICFD_DATABASE_TIMESTEP
$#   outlv
         1
*DATABASE_BINARY_D3PLOT
&dt_plot
*ICFD_DATABASE_POINTOUT
$#    psid     dtout    pstype
         1     0.005         0
$#     pid         x         y         z
         1      0.05     0.001     0.025
         2      0.05      0.07     0.025
         3      0.05      0.13     0.025
         4      0.01      0.04     0.025
*END
