FH55PRE ;Hines OIFO/RTK RECURRING MEALS RELEASE POST-INIT  ;2/18/03  10:15
 ;;5.5;DIETETICS;;Jan 28, 2005
 ;
ITEM1 ;File #119.9 contains new fields.  Delete any old fields that may
 ;still be hanging around where new fields should be
 I $P($G(^FH(119.9,1,"CV")),U,1)=1 Q  ;QUIT IF 5.5 PREVIOUSLY INSTALLED
 S DIK="^DD(119.9,",DA(1)=119.9
 F DA=4.5,5.1,5.3,5.5,21.5,23,24,25,26,27,30,30.1,30.2,30.3,30.4,30.5,31,31.1,31.2,31.3,31.4,31.5,32,32.1,32.2,32.3,32.4,32.5,41,42,43,44,45,46,76 D ^DIK
 Q
