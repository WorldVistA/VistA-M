DINIT0FN ;SFISC/MKO-DATA FOR FORM AND BLOCK FILES ;10:49 AM  30 Mar 1999
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 F I=1:2 S X=$T(ENTRY+I) G:X="" ^DINIT02 S Y=$E($T(ENTRY+I+1),5,999),X=$E(X,4,999),@X=Y
 Q
ENTRY ;
 ;;^DIST(.404,.4612,40,15,.1)
 ;;=I $D(DDMPFDSL("CAP",6+DDMPOSET)) N DDMPNUM,DDMPLEN S DDMPNUM=6+DDMPOSET,DDMPLEN=$L(DDMPFDSL("CAP",DDMPNUM)),Y=$S($G(DDMPMRK(DDMPNUM)):"*",1:" ")_$S(DDMPNUM<10:" ",1:"")_DDMPNUM_" - "_$E(DDMPFDSL("CAP",DDMPNUM),DDMPLEN-70,DDMPLEN)
 ;;^DIST(.404,.4612,40,15,2)
 ;;=^^14,4^1
 ;;^DIST(.404,.4612,40,16,0)
 ;;=5.7^!M^1
 ;;^DIST(.404,.4612,40,16,.1)
 ;;=I $D(DDMPFDSL("CAP",7+DDMPOSET)) N DDMPNUM,DDMPLEN S DDMPNUM=7+DDMPOSET,DDMPLEN=$L(DDMPFDSL("CAP",DDMPNUM)),Y=$S($G(DDMPMRK(DDMPNUM)):"*",1:" ")_$S(DDMPNUM<10:" ",1:"")_DDMPNUM_" - "_$E(DDMPFDSL("CAP",DDMPNUM),DDMPLEN-70,DDMPLEN)
 ;;^DIST(.404,.4612,40,16,2)
 ;;=^^15,4^1
 ;;^DIST(.404,.4612,40,17,0)
 ;;=5.8^!M^1
 ;;^DIST(.404,.4612,40,17,.1)
 ;;=I $D(DDMPFDSL("CAP",8+DDMPOSET)) N DDMPNUM,DDMPLEN S DDMPNUM=8+DDMPOSET,DDMPLEN=$L(DDMPFDSL("CAP",DDMPNUM)),Y=$S($G(DDMPMRK(DDMPNUM)):"*",1:" ")_$S(DDMPNUM<10:" ",1:"")_DDMPNUM_" - "_$E(DDMPFDSL("CAP",DDMPNUM),DDMPLEN-70,DDMPLEN)
 ;;^DIST(.404,.4612,40,17,2)
 ;;=^^16,4^1
 ;;^DIST(.404,.4612,40,18,0)
 ;;=5.9^!M^1
 ;;^DIST(.404,.4612,40,18,.1)
 ;;=I $D(DDMPFDSL("CAP",9+DDMPOSET)) N DDMPNUM,DDMPLEN S DDMPNUM=9+DDMPOSET,DDMPLEN=$L(DDMPFDSL("CAP",DDMPNUM)),Y=$S($G(DDMPMRK(DDMPNUM)):"*",1:" ")_$S(DDMPNUM<10:" ",1:"")_DDMPNUM_" - "_$E(DDMPFDSL("CAP",DDMPNUM),DDMPLEN-70,DDMPLEN)
 ;;^DIST(.404,.4612,40,18,2)
 ;;=^^17,4^1
 ;;^DIST(.404,.4612,40,19,0)
 ;;=2.3^!M^2^^LEN
 ;;^DIST(.404,.4612,40,19,.1)
 ;;=S Y=$S($G(DDMPSMFF("FIXED"))="YES":"Length",1:"")
 ;;^DIST(.404,.4612,40,19,2)
 ;;=6,12^3^6,4
 ;;^DIST(.404,.4612,40,19,11)
 ;;=I $$GET^DDSVALF("FLD")']"" S DDSBR=$S($L($G(DDMPCPTH)):"FLD",1:"FLD_DEL")
 ;;^DIST(.404,.4612,40,19,12)
 ;;=I X="" S DDSBR="2^1^4"
 ;;^DIST(.404,.4612,40,19,13)
 ;;=S DDMPFDSL("LN",DDMPFDCT)=X,DDMPFDSL("CAP",DDMPFDCT)=DDMPFDSL("CAP",DDMPFDCT)_"["_X_"]",DDSBR="FLD" D PUT^DDSVALF("LEN","","",""),PUT^DDSVALF("FLD","","",""),REFRESH^DDSUTL
 ;;^DIST(.404,.4612,40,19,20)
 ;;=N^^1:255
 ;;^DIST(.404,.4612,40,19,21,0)
 ;;=^^2^2^2950228
 ;;^DIST(.404,.4612,40,19,21,1,0)
 ;;=Enter the length of the imported data associated with this field.  (This
 ;;^DIST(.404,.4612,40,19,21,2,0)
 ;;=applies only to fixed length imports.)
 ;;^DIST(.404,.4613,0)
 ;;=DDMP FILE CHANGE^.44
 ;;^DIST(.404,.4613,40,0)
 ;;=^.4044I^3^3
 ;;^DIST(.404,.4613,40,1,0)
 ;;=1^If you delete or change the primary file,^1
 ;;^DIST(.404,.4613,40,1,2)
 ;;=^^1,1
 ;;^DIST(.404,.4613,40,2,0)
 ;;=2^the fields you have chosen will be deleted.^1
 ;;^DIST(.404,.4613,40,2,2)
 ;;=^^2,1^1
 ;;^DIST(.404,.4613,40,3,0)
 ;;=3^Do you want to change the Primary file?^2
 ;;^DIST(.404,.4613,40,3,2)
 ;;=4,42^3^4,1
 ;;^DIST(.404,.4613,40,3,3)
 ;;=Yes
 ;;^DIST(.404,.4613,40,3,4)
 ;;=1
 ;;^DIST(.404,.4613,40,3,12)
 ;;=D CHNGFILE^DDMPSM S DDACT="CL"
 ;;^DIST(.404,.4613,40,3,20)
 ;;=Y
 ;;^DIST(.404,.4614,0)
 ;;=DDMP REQUIRED LENGTH
 ;;^DIST(.404,.4614,40,0)
 ;;=^.4044I^3^3
 ;;^DIST(.404,.4614,40,1,0)
 ;;=1^Since this is a fixed length import,^1
 ;;^DIST(.404,.4614,40,1,2)
 ;;=^^1,1
 ;;^DIST(.404,.4614,40,2,0)
 ;;=1.2^you must enter a data length for every field.^1
 ;;^DIST(.404,.4614,40,2,2)
 ;;=^^2,1
 ;;^DIST(.404,.4614,40,3,0)
 ;;=2^Delete field or enter its Length (D/L)?^2
 ;;^DIST(.404,.4614,40,3,2)
 ;;=4,41^1^4,1^1
 ;;^DIST(.404,.4614,40,3,13)
 ;;=D LENCHK^DDMPSM1
 ;;^DIST(.404,.4614,40,3,20)
 ;;=S^M^D:Delete the field;L:Length will be entered
 ;;^DIST(.404,.4614,40,3,21,0)
 ;;=^^4^4^2950301
 ;;^DIST(.404,.4614,40,3,21,1,0)
 ;;=You left the length prompt without entering a data length for the last
 ;;^DIST(.404,.4614,40,3,21,2,0)
 ;;=field you specified.  Since you have chosen a fixed length import, you
 ;;^DIST(.404,.4614,40,3,21,3,0)
 ;;=must give a length for every field.  You can choose to either delete the
 ;;^DIST(.404,.4614,40,3,21,4,0)
 ;;=field you just entered or return to the Length prompt to enter a Length.
