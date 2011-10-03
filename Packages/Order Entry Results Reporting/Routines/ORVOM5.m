ORVOM5 ; slc/dcm - ONIT creation ;1/14/91  09:55 ;
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;;Dec 17, 1997
 S Q=1 K ^UTILITY($J)
 S X="T",%DT="" D ^%DT
 S Y=$P("JAN^FEB^MAR^APR^MAY^JUN^JUL^AUG^SEP^OCT^NOV^DEC",U,$E(Y,4,5))_" "_$S(Y#100:$J(Y#100\1,2)_",",1:"")_(Y\10000+1700)_$S(Y#1:"  "_$E(Y_0,9,10)_":"_$E(Y_"000",11,12),1:"")
 S DRN=17,DIRS=" S DIFQ=1"
 S X=0
 S F=0 F  S F=$O(F(F)) Q:F=""  S X=X+1,DH=$P(@(F(F,0)_"0)"),U,2),^UTILITY($J,27+X,0)=" ;;"_DH_";"_F(F)_";"_$S($D(DTL(F)):DTL(F)+1,1:0)_";"_F(F,0)_";"_$S($D(F(F,F)):F(F,F),1:"")
 S ^UTILITY($J,9,0)=" L  W !"_$S(Q:",$C(7),""OK, Protocol Installation is Complete."",!",1:"")_$S(Q:"",1:" D ^"_Q)
 S ^UTILITY($J,9.3,0)=" K %ZW,%,%H,D0,DA,DIF,DIFQ,DIG,DIH,DIK,DIU,DIV,DSEC,I,J,KEY,DIY,N,NM,NO,ORVROM,R,X,X0"
 S ^UTILITY($J,9.5,0)=" Q"
 F D=1:1 S E=$P($T(T+D),";",3,999) Q:E=""  S:E="IXF ;;" E=E_DTL S ^UTILITY($J,9+D,0)=E,ORVROM=X+3
 G ^ORVOM6
T ;
 ;; ;
 ;;Q W $C(7),!!,"NO UPDATING HAS OCCURRED!" Q
 ;; ;
 ;;IXF ;;
