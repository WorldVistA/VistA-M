PRCH212P ;WISC/CR - CLEAN UP OF EXTRA CROSS REF. IN FILE #442 ; 06/30/99
 ;;5.0;IFCAP;**212**;4/21/95
 ; 
 ; Quit if entry point is not used.
 W $C(7),!!,"Illegal entry point.",!
 Q
 ; This is a post init routine that will be used with patch PRC*5*212
 ; to clean up extra "AB" cross references for field .1 of file #442.
 ; This cross reference is created when the P.O. DATE field is populated
 ; during the creation of a purchase order. After patch PRC*5*212 is 
 ; installed, file #442 will be free from extra "AB" cross references.
 ; This routine should be deleted from th system upon installation of
 ; patch PRC*5*212.
START ;
 K ^PRC(442,"AB")
 S DIK="^PRC(442,",DIK(1)=".1^AB"
 D ENALL^DIK
 Q
