$-----------------------------------------------------------------------------
$
$ Example provided by Iñaki (LSTC)
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
$X    Requires LS-DYNA MPP R8.0.0 (or higher) with double precision 
$X
$X------------------------------------------------------------------------------
$# UNITS: (kg/m/s) 
$X------------------------------------------------------------------------------
$X
*KEYWORD  
*TITLE
ICFD  Dam break with elastic gate opening
*PARAMETER
$
$--- Struc
$
Rrho_struc      1100
R  E_struc      10e6
Rnu_struc1       0.4 
Rnu_struc2     0.495 
R dt_struc    0.0005
*INCLUDE
mesh_struc.k
*CONTROL_TERMINATION
$#  endtim    endcyc     dtmin    endeng    endmas
    &T_end
*CONTROL_IMPLICIT_GENERAL
$#  imflag       dt0
         1 &dt_struc
*CONTROL_IMPLICIT_SOLUTION
$#  nsolvr    ilimit    maxref     dctol     ectol
        12     1000       1000      1e-6      1e-6
*CONTROL_IMPLICIT_DYNAMICS
$#  imass      gamma      beta
        1        0.6       0.4
*PART
$# title
                                                                                
$#     pid     secid       mid     eosid      hgid      grav    adpopt      tmid
         1         1         1         0         0         0         0        
*SECTION_SHELL
$#   secid    elform      shrf       nip     propt   qr/irid     icomp     setyp
         1        12  1.000000         5         1         0         0         1
$#      t1        t2        t3        t4      nloc     marea      idof    edgset
     0.000     0.000     0.000     0.000     0.000     0.000     0.000         0
*MAT_MOONEY-RIVLIN_RUBBERmat_mooney-rivlin_rubber
$#     mid        ro        pr         n
         1&rho_struc&nu_struc1         2
$#     sgl        sw        st      lcid
         1         1         1         7
*MAT_ELASTIC
$#     mid        ro         e        pr         n    couple         m     alias
         2&rho_struc  &E_struc&nu_struc1     0.000     0.000     0.000 
*MAT_OGDEN_RUBBER
$#     mid        ro        pr         n
         3&rho_struc&nu_struc1         2
$#     sgl        sw        st      lcid
         1         1         1         7
*DEFINE_CURVE_TITLE
strain-stress curve
$#    lcid      sidr       sfa       sfo      offa      offo    dattyp
         7
0,0
$0.001,10000
0.00395534,56916.5
0.00889952,86812.9
0.0197767,135734
0.0286762,176502
0.0385646,217270
0.048453,255320
0.0593301,290652
0.0692185,323266
0.0791069,350445
0.0899841,383059
0.0998724,412956
0.199745,652127
0.301595,855966
0.403445,1.00545e+006          
*END
