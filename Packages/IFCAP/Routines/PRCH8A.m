PRCH8A ;WISC/PLT-AUTO GENERATE FMS ET-DOCUMENTS ; 09/10/96  9:36 AM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 QUIT  ;invalid entry
 ;
 ;.X = record id of file 2100.1 if generated, "" if fail
 ;PRCFC data: ^1=ri of 440.6, ^2=ri of 442, ^3 =1 if 440.6 is d, =2 if 442 is d, ^4 = BOC from 442
 ;PRCID data ^1=file 2100.1 ri, ^2= document id (if regenerated)
ET(X,PRCFC,PRCID) ;ET auto document
 N PRCA,PRCB,PRCC,PRCDDT,PRCF,PRCQ,PRCRI,PRCSITE,PRCY,GECSFMS,PRCLACT,PRCAP,PRCDD
 N PRCDI,PRCBOC,PRCEM,PRCIDL
 N A,B,Z
 S PRCRI(440.6)=$P(PRCFC,"^"),PRCRI(442)=$P(PRCFC,"^",2),PRCDI=$P(PRCFC,"^",3),PRCBOC=$P(PRCFC,"^",4)
 S PRCIDL=$P(^PRCH(440.6,PRCRI(440.6),0),"^")
 S PRCDD=$$DD^PRCH0A(PRCRI(440.6)_"^"_DT,PRCRI(442)),PRCSITE=$E($P(PRCDD,"^",3),1,3),PRCEM=$P($P(PRCDD,"~",2),"^",9)
 I $G(PRCID)]"" S PRCRI(2100.1)=+PRCID,PRCID=$P(PRCID,"^",2),PRCEM=$S($P(PRCID,"-",2)="":"E",1:"M"),A=$P(PRCDD,"~",2),$P(A,"^",9)=PRCEM,$P(PRCDD,"~",2)=A
 I $G(PRCID)="" S PRCID=$P(PRCDD,"^",3)
 ;D  ;get required fields data and line action code
 ;. D DOCREQ^PRC0C("^"_PRCSITE_"^"_PRCRI(420.01)_"^"_$E(PRCY,3,4)_"^"_$P(PRCFC,"^",7),"ET","PRCF")
 ;. QUIT
 I $G(PRCRI(2100.1)) D REBUILD^GECSUFM1(PRCRI(2100.1),"I",$$SEC1^PRC0C(PRCSITE),"","Edited Rejected Auto ET Document")
 ;add entry in file 2100.1 if not rejected process
 D:$G(PRCRI(2100.1))=""  G EXIT:PRCRI(2100.1)<1
 . D CONTROL^GECSUFMS("I",PRCSITE,PRCID,"ET",$$SEC1^PRC0C(PRCSITE),$S(PRCEM="M":1,1:0),"","Auto ET Document")
 . S PRCRI(2100.1)=GECSFMS("DA")
 . QUIT
 D SETPARAM^GECSSDCT(PRCRI(2100.1),$TR(PRCFC,"^","/"))
 S PRCC=1,PRCB(PRCC)=$P(PRCDD,"~",2)_"^~"
 S PRCB(2)="LIN^~"_$$DDA4406^PRCH0A(PRCRI(440.6))
 S PRCB(3)="LIN^~"_$$DDA442^PRCH0A(PRCRI(442)),$P(PRCB(3),"^",34)=$P(PRCB(2),"^",34) I $G(PRCBOC)]"" S $P(PRCB(3),"^",22)=PRCBOC
 F A=2,3 S $P(PRCB(A),"^",3)=$E(A-2*500+$E(PRCIDL,13,15)+1000,2,4),$P(PRCB(A),"^",35)=$E("DI",A-1),PRCB(A)=PRCB(A)_"^~"
 I PRCDI=2 F A=2,3 S $P(PRCB(A),"^",35)=$E("ID",A-1)
 I $P(PRCB(2),"^",34)<0 S A=$P(PRCB(2),"^",35),$P(PRCB(2),"^",35)=$P(PRCB(3),"^",35),$P(PRCB(3),"^",35)=A F A=2,3 S $P(PRCB(A),"^",34)=$E($P(PRCB(A),"^",34),2,999)
 I $P(PRCB(2),"^",35)'="D" S A=PRCB(2),PRCB(2)=PRCB(3),PRCB(3)=A
 S PRCA="" F  S PRCA=$O(PRCB(PRCA)) Q:'PRCA  D SETCS^GECSSTAA(PRCRI(2100.1),PRCB(PRCA))
 D SETSTAT^GECSSTAA(PRCRI(2100.1),"Q")
EXIT S X=$G(PRCRI(2100.1))_"^"_PRCID
 QUIT
