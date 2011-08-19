DGMTR1 ;ALB/CJM,SCG,LBD - Check Means Test Requirements Cont'd;3/25/92  09:51
 ;;5.3;Registration;**182,344,433,456,564,688**;Aug 13, 1993;Build 29
 ;
COPYRX(DFN,MTIEN) ;
 ;Creates a Pharmacy Copay test based on the means test if the vet is
 ;subject to the Rx copayment and the income screening was already
 ;completed
 ;1/16/2002 - Changes added for LTC Copay Phase II (DG*5.3*433)
 ;Creates a Pharmacy Copay test based on a LTC copay exemption test
 ;(type 4) if the veteran is exempt from means test
 ;
 N NODE0,RXSTATUS,Y,DGMT,DGMTYPT,DGNODE,DATA,SUB,COMMENTS,RXIEN,DGMTACT,DGMTI,DGMTP,DGMTA,NODE2,CODE,QUIT,TRIES,ERROR,TYPE
 ;
 S DGMTP="",DGMTACT="ADD"
 D ON^DGMTCOU G:'Y COPYRXQ
 I $$CHK(DFN) D
 .S NODE0=$G(^DGMT(408.31,MTIEN,0))
 .Q:NODE0=""
 .S NODE2=$G(^DGMT(408.31,MTIEN,2))
 .;
 .;get type of test (1=means test; 4=LTC copay exemption test)
 .S TYPE=$P(NODE0,"^",19)
 .;
 .;must have been completed
 .S CODE=$$GETCODE^DGMTH($P(NODE0,"^",3))
 .S QUIT=1
 .I (CODE'=""),("ACGP01"[CODE) S QUIT=0
 .S CODE=$$GETCODE^DGMTH($P(NODE2,"^",3))
 .I (CODE'=""),("ACGP01"[CODE) S QUIT=0
 .Q:QUIT
 .;
 .;must still be effective
 .Q:($$FMDIFF^XLFDT(DT,$P(NODE0,"^"))>365)
 .Q:$$OLD^DGMTU4($P(NODE0,"^"))
 .Q:($P(NODE0,"^",14))  ;declined to provide income information
 .Q:($P(NODE0,"^",26))  ;refused to sign the test
 .F TRIES=1:1 D  Q:(TRIES>3)
 ..S DGNODE=$$LST^DGMTU(DFN,$S((DT>$P(NODE0,"^",2)):DT,1:$P(NODE0,"^",2)),2),RXIEN=+DGNODE
 ..;
 ..;mark existing test as non-primary
 ..I RXIEN,($E($P(DGNODE,"^",2),1,3)=$E($P(NODE0,"^"),1,3)) D
 ...S DATA(2)=0 I $$UPD^DGENDBS(408.31,RXIEN,.DATA)
 ..E  S TRIES=4
 .;
 .S RXIEN=$P(NODE2,"^",6)
 .;if already copied, reuse the same record
 .I RXIEN,$P($G(^DGMT(408.31,RXIEN,2)),"^",6)=MTIEN D
 ..S DGMTI=RXIEN
 ..; Check for another test in the current year and convert IAI records, if needed
 ..S CONVRT=$$VRCHKUP^DGMTU2(2,TYPE,$P(^DGMT(408.31,MTIEN,0),"^"),$P(^DGMT(408.31,RXIEN,0),"^"))
 .E  D  Q:'DGMTI
 ..;This call works. Adding via the ADD^DGENDBS encountered an error
 ..S DGMTDT=$P(NODE0,"^") S DGMTYPT=2 D ADD^DGMTA
 .;
 .S DATA(.019)=2
 .S DATA(.03)=""
 .F SUB=.01,.02,.04,.05,.06,.07,.14,.15,.18,.23,.24,.25 S DATA(SUB)=$P(NODE0,"^",(SUB/.01))
 .S DATA(2)=1
 .S DATA(2.02)=$P(NODE2,"^",2)
 .S DATA(2.05)=$P(NODE2,"^",5)
 .I TYPE=1 D
 ..S DATA(2.06)=MTIEN
 ..S COMMENTS("LINES",1,0)="This Rx Copay Test was automatically created based on a completed means test"
 ..S COMMENTS("LINES",2,0)="which was changed to NO LONGER REQUIRED. All data including income"
 ..S COMMENTS("LINES",3,0)="screening was copied from the test on "_$$FMTE^XLFDT($$NOW^XLFDT)_"."
 .I TYPE=4 D
 ..S COMMENTS("LINES",1,0)="This Rx Copay Test was automatically created based on a completed"
 ..S COMMENTS("LINES",2,0)="LTC copay exemption test. All data including income screening"
 ..S COMMENTS("LINES",3,0)="was copied from the test on "_$$FMTE^XLFDT($$NOW^XLFDT)_"."
 .S DATA(50)="COMMENTS(""LINES"")"
 .S (DATA(.03),DATA(2.03))=$$RXSTATUS(MTIEN)
 .S DATA(2.11)=1
 .I $$UPD^DGENDBS(408.31,DGMTI,.DATA,.ERROR)
 .K DATA
 .S:TYPE=1 DATA(2.06)=DGMTI
 .S:TYPE=4 DATA(2.08)=DGMTI
 .I $$UPD^DGENDBS(408.31,MTIEN,.DATA,.ERROR)
 .D TRANSFER^DGMTU4(DFN,MTIEN,DGMTI)
 .D QUE^DGMTR
COPYRXQ ;
 K ERROR
 Q
 ;
RXSTATUS(MTIEN) ;
 ;Determins RX Copay Status based on the means test
 ;
 Q:('$G(MTIEN)) ""
 N NODE0,NODE,PIECE,IBSTATUS,MTSTATUS
 S NODE0=$G(^DGMT(408.31,MTIEN,0))
 Q:(NODE0="") ""
 F PIECE=1,2,4,5,14,15,18 S $P(NODE,"^",PIECE)=$P(NODE0,"^",PIECE)
 S $P(NODE,"^",19)=2
 S IBSTATUS=+$$INCDT^IBARXEU1(NODE)
 S MTSTATUS=$S(IBSTATUS=1:"E",IBSTATUS=2:"M",1:"")
 Q:(MTSTATUS="") ""
 Q $O(^DG(408.32,"AC",2,MTSTATUS,0))
 ;
CHK(DFN) ;
 ;can the veteran take a RX copay test?
 N DGMTI,DGMTCOR,DGNODE,DGELIG,DGI,DGE
 S DGMTCOR=1
 ;
 I $P($G(^DPT(DFN,"VET")),U,1)'="Y" S DGMTCOR=0 G CHKQ ;NON-VET
 S DGI=$P($G(^DPT(DFN,.36)),U) I 'DGI S DGMTCOR=0 G CHKQ ;NO PRIM ELIG
 S DGELIG=U_$P($G(^DIC(8,+DGI,0)),U,9)_U
 S DGI=0 F  S DGI=$O(^DPT(DFN,"E",DGI)) Q:'DGI  S DGE=$P($G(^DPT(DFN,"E",DGI,0)),U),DGELIG=DGELIG_$P($G(^DIC(8,+DGE,0)),U,9)_U
 I (DGELIG["^1^") S DGMTCOR=0 G CHKQ  ;SC 50-100%
 F DGI=.3,.362,.52 S DGNODE(DGI)=$G(^DPT(DFN,DGI))
 I $P(DGNODE(.362),U,12)["Y"!(DGELIG["^2^") S DGMTCOR=0 G CHKQ ;A&A
 I $P(DGNODE(.362),U,13)["Y"!(DGELIG["^15^") S DGMTCOR=0 G CHKQ ;HB
 I $P(DGNODE(.362),U,14)["Y"!(DGELIG["^4^") S DGMTCOR=0 G CHKQ ;PENSION
 I $P(DGNODE(.52),U,5)["Y"!(DGELIG["^18^") S DGMTCOR=0 G CHKQ ;POW
 I $P(DGNODE(.3),U,5)["Y"&($P(DGNODE(.3),U,2)>0)&($P(DGNODE(.362),U,20)>0) S DGMTCOR=0 G CHKQ ;UNEMPLOYABLE
CHKQ ;
 Q DGMTCOR
MAIL ; Send a mailman msg to user/ INCONSISTENCY EDIT GROUP with results
 N %,DGB,I,VA,VADM,VAERR,Y,XMDUZ,XMSUB,XMTEXT,XMY,XMZ
 D DEM^VADPT
 S XMSUB="Patient "_VADM(1)_" has an invalid secondary eligibility"
 S XMDUZ="PIMS PACKAGE",XMY(DUZ)="",XMY(.5)=""
 S DGB=+$P($G(^DG(43,1,"NOT")),"^",6)
 I $D(^XMB(3.8,DGB,0)) S XMY("G."_$P($G(^XMB(3.8,DGB,0)),"^"))=""
 S XMTEXT="DGTXT("
 D NOW^%DTC S Y=% D DD^%DT
 S DGTXT(1)="On "_Y_"  "_VADM(1)_" ("_VA("BID")_")"
 S DGTXT(2)="has an invalid secondary eligibility"
 S DGTXT(3)="  "
 ;que mailman message
 N DIFROM,I,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK
 F I="DGTXT(","XMDUZ","XMSUB","XMTEXT","XMY(" S ZTSAVE(I)=""
 S ZTDESC="MAILMAN MSG FOR INVALID ELIGIBILITY CODE FILE ENTRIES"
 S ZTDTH=$$NOW^XLFDT(),ZTIO="",ZTRTN="^XMD"
 D ^%ZTLOAD
 Q
