RMPFDE3 ;DDC/PJU - RE ELIGIBILITY APPROVAL PROCESS ;7/8/04
 ;;3.0;REMOTE ORDER/ENTRY SYSTEM;**1**;11/1/02
 ;CALLED DURING OPTION RMPFDE2 TO PROCESS PENDING ELIGIBILITIES
DISPLINE        ;
 ;RMPFX=req dt^pat name^pat SSN^sug el^dfn^req DUZ^MSG #
 N EL,I,IEN,NM,RD,RMMSG,RMPFOUT,RMPFQUT,RMPFSEL,RO,RQ,SSN,X,Y
 S RD=$P(RMPFX,U,1),NM=$P(RMPFX,U,2),SSN=$P(RMPFX,U,3)
 S EL=$P(RMPFX,U,4),RQ=$P(RMPFX,U,6),RMMSG=$P(RMPFX,U,7)
 S IEN=$P(RMPFX,U,8),RO=0
 W !!!,?4,$$FMTE^XLFDT(RD),?24,NM
 W ?43,$E(SSN,1,3),"-",$E(SSN,4,5),"-",$E(SSN,6,$L(SSN)),?56,EL
 W ! F I=1:1:80 W "-"
 W !?13,"Proposed Eligibility: ",EL
 W !?23,"Entered By: ",$S(RQ:$P($G(^VA(200,RQ,0)),U,1),1:"UNKNOWN")
 I RMMSG,$D(^XMB(3.9,RMMSG,2))>9 D
 .W !?4,"Comments: " S I=6 F  S I=$O(^XMB(3.9,RMMSG,2,I)) Q:'I  D
 ..W !,^XMB(3.9,RMMSG,2,I,0)
A0 W !!,"<A>ccept, <E>dit, <R>eject or <RETURN> to listing: "
 D:$G(RMPFVFLG)=1 READ^RMPFDE2 G END:$D(RMPFOUT)
A1 I $D(RMPFQUT) D  G A0
 .W !!,"Enter an <A> to accept the proposed eligibility"
 .W !?6,"an <E> to change to an acceptable eligibility"
 .W !?6,"an <R> to reject the request back to ASPS or"
 .W !?7,"a <RETURN> to exit back to the list."
 G END:Y=""
 S RMPFSEL=$E(Y,1),RMPFSEL=$$UP^XLFSTR(RMPFSEL)
 S EL=$TR(EL," ","")
 I "AER"'[RMPFSEL S RMPFQUT="" G A1
 S DIE="^RMPF(791814,",DA=IEN K DR
 I "AR"[RMPFSEL D  D:'RO MAIL D:RO MSG G END
 .I EL="",RMPFSEL="A" S RO=1 Q
 .S DR=".04///"_$$FMADD^XLFDT(DT,730) ; 730 days to expire (2 yrs)
 .S DR=DR_";2.01////"_EL_";2.03////"_DUZ_";2.04////"_DT
 .I RMPFSEL="A" S DR=DR_";2.02////1"
 .E  S DR=DR_";2.02////0" ;reject
 .D ^DIE
 I "Ee"[RMPFSEL D  G:$D(RMPFOUT) END D:'RO MAIL D:RO MSG G END
 .W !
 .F X=1:1:18 W !,X,?4,$P($T(@X),";;",2),?15,$P($T(@X),";;",3) ;list eligibilities
A2 .S Y=""
 .W !!,"Enter the line number of the preferred eligibility: "
 .D:$G(RMPFVFLG)=1 READ^RMPFDE2
 .G:$D(RMPFQUT) A2 Q:$D(RMPFOUT)
 .I (Y<1)!(Y>18) S RO=1 Q
 .S EL=$P($T(@Y),";;",2) I EL="" S RO=1 Q
 .S DR=".04///"_$$FMADD^XLFDT(DT,730) ;730 days to expire (2 yrs)
 .S DR=DR_";2.01////"_EL_";2.03////"_DUZ_";2.04////"_DT
 .S DR=DR_";2.02////1" ;accept selected elig
 .D ^DIE K DR
END K DIE,DR,DA Q
 ;
MSG W !!,"*** No eligibility was selected. ***" R X:5 Q
 ;
MAIL ;;Send message to ASPS mail group
 ;; input: EL,NM,SSN
 ;;output: XMZ
 S XMZ=""
 S MG=$O(^XMB(3.8,"B","RMPF ROES UPDATES (ASPS)",0))
 I 'MG D  G MAILE
 .W $C(7),!!,"*** MAIL GROUP - RMPF ROES UPDATES (ASPS) - NOT ESTABLISHED - NO MESSAGE SENT ***"
 S XMY("G."_$P($G(^XMB(3.8,MG,0)),U,1))=""
 S MG=$O(^XMB(3.8,"B","RMPF ROES UPDATES (PSAS)",0))
 I 'MG W $C(7),!!,"*** MAIL GROUP - RMPF ROES UPDATES (PSAS) - NOT ESTABLISHED ***"
 E  S XMY("G."_$P($G(^XMB(3.8,MG,0)),U,1))=""
 S XMY(DUZ)=""
 S XMSUB="ROES PATIENT ELIGIBILITY UPDATE"
 S XMDUZ=DUZ
 D XMZ^XMA2 I XMZ<1 D  G MAILE
 .W !!,"*** MAIL Msg not created! Eligibility not updated! ***"
 S XMTEXT(1)="ROES Patient Eligibility has been updated for the following patient:"
 S XMTEXT(2)=" "
 S XMTEXT(3)=NM_"          "_SSN
 S XMTEXT(4)=" "
 S XMTEXT(5)="Eligibility: "_EL
 S XMTEXT(6)=" "
 S X="" S:$D(^RMPF(791814,IEN,2)) X=$P(^(2),U,2) S X=$S(X=1:"Has been Accepted",X=0:"Has been Rejected",1:"Is Waiting processing")
 S XMTEXT(7)="Comment: "_X
 S XMTEXT="XMTEXT("
 D ^XMD W !!,"*** Message sent to user and Mail Group ***" H 2
MAILE K MG,XMTEXT,XMDUZ,XMSUB,XMY
 Q
ELGLIST ;;LIST THE POSSIBILE ELIGIBILITIES
1 ;;SC;;Service Connected for Hearing Loss
2 ;;COM;;10 to 100 PerCent Service Connected Disability
3 ;;EP3;;Enrollment Priority Group 3 (PH, etc.)
4 ;;POW;;Prisoner of War
5 ;;AAA;;Aid and Attendance
6 ;;HB;;Housebound
7 ;;0CA;;0 PerCent SC and Priority Groups 5 or 7a
8 ;;NCA;;NSC_Pension or (NSC and Prioity Groups 5)
9 ;;SCV;;Special Category Veterans in Priority Group 6
10 ;;CAN;;Canadian Vet
11 ;;BRI;;Great Britain Vet
12 ;;WWI;;World War I or Mexican Border War
13 ;;NSC;;NSC and Priority Group 7c
14 ;;BLR;;Blind Rehab
15 ;;VOC;;Vocational Rehab
16 ;;OGA;;Other Approved Federal Agencies
17 ;;PG8;;Priority Group 8 (pays co-pay)
18 ;;PG4;;Catastrophic Disability
