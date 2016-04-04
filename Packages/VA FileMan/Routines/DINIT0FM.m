DINIT0FM ;SFISC/MKO-DATA FOR FORM AND BLOCK FILES ;10:49 AM  30 Mar 1999
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 F I=1:2 S X=$T(ENTRY+I) G:X="" ^DINIT0FN S Y=$E($T(ENTRY+I+1),5,999),X=$E(X,4,999),@X=Y
 Q
ENTRY ;
 ;;^DIST(.404,.4611,40,17,22)
 ;;=K:$L(X)>15!($L(X)<1)!'((X?1AP.E)!(X?3N)!(X?3N1","3N)!(X?3N1","3N1","3N)!(X?3N1","3N1","3N1","3N)) X
 ;;^DIST(.404,.4611,40,18,0)
 ;;=5.7^Fields quoted?^2^^QUOTE
 ;;^DIST(.404,.4611,40,18,2)
 ;;=12,23^3^12,8^1
 ;;^DIST(.404,.4611,40,18,13)
 ;;=S DDMPSMFF("QUOTED")=DDSEXT
 ;;^DIST(.404,.4611,40,18,20)
 ;;=Y
 ;;^DIST(.404,.4611,40,18,21,0)
 ;;=^^4^4^2950216
 ;;^DIST(.404,.4611,40,18,21,1,0)
 ;;=If the values of some fields are surrounded by quotation marks ("), enter
 ;;^DIST(.404,.4611,40,18,21,2,0)
 ;;=YES.  Field delimiters that occur within the quotation marks are ignored.
 ;;^DIST(.404,.4611,40,18,21,3,0)
 ;;=This special treatment of quotation marks is not done for fixed length
 ;;^DIST(.404,.4611,40,18,21,4,0)
 ;;=data.
 ;;^DIST(.404,.4611,40,20,0)
 ;;=7.4^!M^2^^FLD_JUMP
 ;;^DIST(.404,.4611,40,20,.1)
 ;;=S Y=$S($$GET^DDSVALF("F_SEL",1,1)]"":"Field selection page...",1:"")
 ;;^DIST(.404,.4611,40,20,2)
 ;;=14,69^1^14,44^1
 ;;^DIST(.404,.4611,40,20,4)
 ;;=^^^1
 ;;^DIST(.404,.4611,40,20,10)
 ;;=S DDSBR="FLD^1^2"
 ;;^DIST(.404,.4611,40,20,11)
 ;;=I $$GET^DDSVALF("TMP_NM",1,1)]"" N DDMPMSG S DDMPMSG(1)="You cannot select fields because you have specified an Import Template for this import.",DDMPMSG(2)="$$EOP" D HLP^DDSUTL(.DDMPMSG) S DDSBR="TMP_NM"
 ;;^DIST(.404,.4611,40,20,20)
 ;;=F
 ;;^DIST(.404,.4611,40,20,21,0)
 ;;=^^1^1^2960918
 ;;^DIST(.404,.4611,40,20,21,1,0)
 ;;=Press <RET> to advance to the Field Selection Page.
 ;;^DIST(.404,.4611,40,21,0)
 ;;=5.4^OR^1
 ;;^DIST(.404,.4611,40,21,2)
 ;;=^^9,14^1
 ;;^DIST(.404,.4611,40,22,0)
 ;;=7.6^!M^1^^OR
 ;;^DIST(.404,.4611,40,22,.1)
 ;;=S Y=$S($$GET^DDSVALF("F_SEL",1,1)]"":"OR",1:"")
 ;;^DIST(.404,.4611,40,22,2)
 ;;=^^15,54
 ;;^DIST(.404,.4611,40,23,0)
 ;;=7.8^!M^2^^TMP_NM
 ;;^DIST(.404,.4611,40,23,.1)
 ;;=S Y=$S($$GET^DDSVALF("F_SEL",1,1)]"":"Import Template",1:"")
 ;;^DIST(.404,.4611,40,23,2)
 ;;=16,61^18^16,44
 ;;^DIST(.404,.4611,40,23,4)
 ;;=^^^1
 ;;^DIST(.404,.4611,40,23,11)
 ;;=I $D(DDMPFDSL) N DDMPMSG S DDMPMSG(1)="You have already chosen fields for this import. You may not select an Import Template unless you delete all the chosen fields.",DDMPMSG(2)="$$EOP" D HLP^DDSUTL(.DDMPMSG) S DDSBR="FLD_JUMP"
 ;;^DIST(.404,.4611,40,23,20)
 ;;=P^^.46:AE
 ;;^DIST(.404,.4611,40,23,21,0)
 ;;=^^3^3^2960605
 ;;^DIST(.404,.4611,40,23,21,1,0)
 ;;=Enter the name of an Import Template to use for data import.  If you do
 ;;^DIST(.404,.4611,40,23,21,2,0)
 ;;=not specify a template, you must specify the fields on the Field Selection
 ;;^DIST(.404,.4611,40,23,21,3,0)
 ;;=page.
 ;;^DIST(.404,.4611,40,23,22)
 ;;=S X=$TR(X,"[]")
 ;;^DIST(.404,.4611,40,23,23)
 ;;=S DDMPTMPL=X
 ;;^DIST(.404,.4611,40,23,24)
 ;;=S DIR("S")="I $$TMPLSCR^DDMPSM(DDMPF,DDSEXT,.DUZ)"
 ;;^DIST(.404,.4612,0)
 ;;=DDMP FIELD SELECTION
 ;;^DIST(.404,.4612,40,0)
 ;;=^.4044I^19^18
 ;;^DIST(.404,.4612,40,1,0)
 ;;=1^FIELD SELECTION FOR IMPORT^1
 ;;^DIST(.404,.4612,40,1,2)
 ;;=^^1,27
 ;;^DIST(.404,.4612,40,2,0)
 ;;=1.2^Page 2^1
 ;;^DIST(.404,.4612,40,2,2)
 ;;=^^1,73
 ;;^DIST(.404,.4612,40,3,0)
 ;;=1.1^==========================^1
 ;;^DIST(.404,.4612,40,3,2)
 ;;=^^2,27^1
 ;;^DIST(.404,.4612,40,4,0)
 ;;=2^Choose a field from^1
 ;;^DIST(.404,.4612,40,4,2)
 ;;=^^3,2^1
 ;;^DIST(.404,.4612,40,5,0)
 ;;=2.1^!M^1
 ;;^DIST(.404,.4612,40,5,.1)
 ;;=S Y=$S($D(DDMPFCAP):DDMPFCAP,1:DDMPFLNM)
 ;;^DIST(.404,.4612,40,5,2)
 ;;=^^4,2^1
 ;;^DIST(.404,.4612,40,6,0)
 ;;=2.2^Field^2^^FLD
 ;;^DIST(.404,.4612,40,6,2)
 ;;=5,12^19^5,5
 ;;^DIST(.404,.4612,40,6,10)
 ;;=I X=DDSOLD,$L($G(DDMPCPTH)) S DDSBR=2.2 D UP1^DDMPSM,REFRESH^DDSUTL
 ;;^DIST(.404,.4612,40,6,13)
 ;;=D FDPROC^DDMPSM,PUT^DDSVALF(2.2,1,2,""):$G(DDSBR)="FLD",REFRESH^DDSUTL
 ;;^DIST(.404,.4612,40,6,20)
 ;;=F^^1:30
 ;;^DIST(.404,.4612,40,6,21,0)
 ;;=^^1^1^2950217
 ;;^DIST(.404,.4612,40,6,21,1,0)
 ;;=^N D0,DA,DIC,D,DZ S DIC="^DD("_DDMPCF_",",DIC(0)="",D="B",DIC("S")="I '($P($G(^DD(+$P(^DD(DDMPCF,Y,0),U,2),.01,0)),U,2)[""W"")" S:$G(X)="?" DZ=X D DQ^DICQ
 ;;^DIST(.404,.4612,40,6,22)
 ;;=D IXF^DDMPSM
 ;;^DIST(.404,.4612,40,8,0)
 ;;=3.1^Delete last field selected?^2^^FLD_DEL
 ;;^DIST(.404,.4612,40,8,2)
 ;;=5,68^3^5,40^1
 ;;^DIST(.404,.4612,40,8,11)
 ;;=S DDMPMRK($G(DDMPFDCT))=1 D REFRESH^DDSUTL
 ;;^DIST(.404,.4612,40,8,12)
 ;;=K DDMPMRK D REFRESH^DDSUTL ;S DDSBR="COM"
 ;;^DIST(.404,.4612,40,8,13)
 ;;=I X D DELFLD^DDMPSM,PUT^DDSVALF(3.1,"","","") S DDSBR=3.1
 ;;^DIST(.404,.4612,40,8,20)
 ;;=Y
 ;;^DIST(.404,.4612,40,8,21,0)
 ;;=^^2^2^2960716
 ;;^DIST(.404,.4612,40,8,21,1,0)
 ;;=Enter YES if you want to delete the most recent field that you selected
 ;;^DIST(.404,.4612,40,8,21,2,0)
 ;;=for import.  This is the last field on the list to the left
 ;;^DIST(.404,.4612,40,9,0)
 ;;=4^These are the fields selected so far:^1
 ;;^DIST(.404,.4612,40,9,2)
 ;;=^^8,2
 ;;^DIST(.404,.4612,40,10,0)
 ;;=5.1^!M^1
 ;;^DIST(.404,.4612,40,10,.1)
 ;;=I $D(DDMPFDSL("CAP",1+DDMPOSET)) N DDMPNUM,DDMPLEN S DDMPNUM=1+DDMPOSET,DDMPLEN=$L(DDMPFDSL("CAP",DDMPNUM)),Y=$S($G(DDMPMRK(DDMPNUM)):"*",1:" ")_$S(DDMPNUM<10:" ",1:"")_DDMPNUM_" - "_$E(DDMPFDSL("CAP",DDMPNUM),DDMPLEN-70,DDMPLEN)
 ;;^DIST(.404,.4612,40,10,2)
 ;;=^^9,4^1
 ;;^DIST(.404,.4612,40,11,0)
 ;;=5.2^!M^1
 ;;^DIST(.404,.4612,40,11,.1)
 ;;=I $D(DDMPFDSL("CAP",2+DDMPOSET)) N DDMPNUM,DDMPLEN S DDMPNUM=2+DDMPOSET,DDMPLEN=$L(DDMPFDSL("CAP",DDMPNUM)),Y=$S($G(DDMPMRK(DDMPNUM)):"*",1:" ")_$S(DDMPNUM<10:" ",1:"")_DDMPNUM_" - "_$E(DDMPFDSL("CAP",DDMPNUM),DDMPLEN-70,DDMPLEN)
 ;;^DIST(.404,.4612,40,11,2)
 ;;=^^10,4^1
 ;;^DIST(.404,.4612,40,12,0)
 ;;=5.3^!M^1
 ;;^DIST(.404,.4612,40,12,.1)
 ;;=I $D(DDMPFDSL("CAP",3+DDMPOSET)) N DDMPNUM,DDMPLEN S DDMPNUM=3+DDMPOSET,DDMPLEN=$L(DDMPFDSL("CAP",DDMPNUM)),Y=$S($G(DDMPMRK(DDMPNUM)):"*",1:" ")_$S(DDMPNUM<10:" ",1:"")_DDMPNUM_" - "_$E(DDMPFDSL("CAP",DDMPNUM),DDMPLEN-70,DDMPLEN)
 ;;^DIST(.404,.4612,40,12,2)
 ;;=^^11,4^1
 ;;^DIST(.404,.4612,40,13,0)
 ;;=5.4^!M^1
 ;;^DIST(.404,.4612,40,13,.1)
 ;;=I $D(DDMPFDSL("CAP",4+DDMPOSET)) N DDMPNUM,DDMPLEN S DDMPNUM=4+DDMPOSET,DDMPLEN=$L(DDMPFDSL("CAP",DDMPNUM)),Y=$S($G(DDMPMRK(DDMPNUM)):"*",1:" ")_$S(DDMPNUM<10:" ",1:"")_DDMPNUM_" - "_$E(DDMPFDSL("CAP",DDMPNUM),DDMPLEN-70,DDMPLEN)
 ;;^DIST(.404,.4612,40,13,2)
 ;;=^^12,4^1
 ;;^DIST(.404,.4612,40,14,0)
 ;;=5.5^!M^1
 ;;^DIST(.404,.4612,40,14,.1)
 ;;=I $D(DDMPFDSL("CAP",5+DDMPOSET)) N DDMPNUM,DDMPLEN S DDMPNUM=5+DDMPOSET,DDMPLEN=$L(DDMPFDSL("CAP",DDMPNUM)),Y=$S($G(DDMPMRK(DDMPNUM)):"*",1:" ")_$S(DDMPNUM<10:" ",1:"")_DDMPNUM_" - "_$E(DDMPFDSL("CAP",DDMPNUM),DDMPLEN-70,DDMPLEN)
 ;;^DIST(.404,.4612,40,14,2)
 ;;=^^13,4^1
 ;;^DIST(.404,.4612,40,15,0)
 ;;=5.6^!M^1
