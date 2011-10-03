BPSOS6M ;BHAM ISC/FCS/DRS - Print log of claim ;06/01/2004
 ;;1.0;E CLAIMS MGMT ENGINE;**1,5,8**;JUN 2004;Build 29
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; Display the BPS Log for a given BPS Transaction
 Q
CLAIMLOG(IEN59) ;EP - from BPSSCRDV
 ;
 I '$G(IEN59) Q
 ;
 ; Get Device
 N POP
 D ^%ZIS
 I $G(POP) Q
 U IO
 ;
 ; Determine if this is a terminal
 N BPSCR S BPSCR=$S($E($G(IOST),1,2)="C-":1,1:0)
 ;
 ; Read BPS Transaction into the local variable
 N REC,X,X1,X2 M REC=^BPST(IEN59)
 N I F I=0:1:2 I '$D(REC(I)) S REC(I)=""
 ;
 ; Display Header
 I BPSCR W @IOF
 W "Pharmacy ECME Log of activity for one prescription",!
 ;
 ; Prescription and Transaction Info
 W "Internal Prescription #",$P(REC(1),U,11)
 W "  Fill #",+$P(REC(1),U)
 W !,"VA Prescription #",$$RXAPI1^BPSUTIL1(+$P(REC(1),U,11),.01)
 W !,"Transaction #",IEN59
 ;
 ; Patient
 W !,"Patient: "
 S X=$P(REC(0),U,6) I X]"" S X=$P($G(^DPT(X,0)),U) W X
 ;
 ; Insurance
 W !,"Insurance: "_$$INSNAME^BPSSCRU6(IEN59)
 ;
 ; RX Coord of Benefits
 W !,"RX Coord of Benefits: "
 S X=$P(REC(0),U,14) S X=$S($G(X)>0:$G(X),1:1)
 W $S(X=2:"Secondary",X=3:"Tertiary",1:"Primary")
 ;
 ; Status and Response
 W !!,"Status: "
 S X=$P(REC(0),U,2) W X," (",$$STATI^BPSOSU(X),")"
 I X=99 D DISPRESP
 ;
 ; Transaction Times
 W !!,"Last started on " S X1=$P(REC(0),U,11) I X1]"" W $$DATETIME^BPSOSUD(X1)
 W !,"Last activity on " S X2=$P(REC(0),U,8) I X2]"" W $$DATETIME^BPSOSUD(X2)
 I X1]"",X2]"" W "  Elapsed time: " W $$TIMEDIF^BPSOSUD(X1,X2)
 ;
 ; Claim and Response
 W !!
 S X=$P(REC(0),U,4)
 I X="" W "No entry"
 E  W "See also entry `",X
 W " in file BPS CLAIMS (#9002313.02)",!
 I X]"" D
 . S X=$P(REC(0),U,5)
 . I X="" W "  but there is no entry"
 . E  W "  and entry `",X
 . W " in file BPS RESPONSES (#9002313.03)",!
 ;
 ; Log
 N STOP S STOP=0
 N EXISTS S EXISTS=$$EXISTS^BPSOSL1(IEN59)
 I EXISTS D  Q:$G(STOP)
 . W !,"Log of this claim's activity: ",!
 . I BPSCR S X="" D PAUSE^VALM1 I X="^" S STOP=1 Q
 . D PRINTLOG^BPSOSL1(IEN59,.STOP)
 . I $G(STOP) Q
 . I BPSCR D PRESSANY^BPSOSU5()
 I 'EXISTS D
 . W !,"There is no log for this claim's activity.",!
 . I BPSCR D PRESSANY^BPSOSU5()
 ;
 ; Close Device
 D ^%ZISC
 Q
 ;
 ; Display response info
DISPRESP ;
 N RES
 S RES=$P(REC(2),U)
 I RES=0 D  ; good, go to the claim response and see what it says
 . N RSP D RESPINFO^BPSOSQ4(IEN59,.RSP)
 . W !,"Response Status-Header: ",$G(RSP("HDR"))
 . W !,"Response Status-Prescription: ",$G(RSP("RSP")) ; Payable, Rejected, Captured, Duplicate
 . I $G(RSP("MSG"))]"" W !?10,RSP("MSG")
 . N I F I=1:1:$G(RSP("REJ",0)) W !?10,$G(RSP("REJ",I))
 E  D
 . W !,"Result: ",RES
 . I $P(REC(2),U,2)]"" W " (",$P($P(REC(2),";",1),U,2,$L(REC(2),U)),")"
 Q
