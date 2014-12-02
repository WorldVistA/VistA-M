PSJBCMA6  ;B'ham/JCH - Send Message when Clinic Order Setup incomplete ; 18 Aug 98 / 2:48 PM
 ;;5.0;INPATIENT MEDICATIONS;**279**;16 DEC 97;Build 150
 ;
 Q
NOCLDEF(DFN,ORDER) ; If clinic not defined in Clinic Definition file for Pending order, send message
 Q:'$G(DFN)!'$G(ORDER)  Q:'(ORDER["P")
 N I,CL,CLNM,PSJMARR,DIC,X,Y,NDP2,ND0,MSG2
 S CL=$G(^PS(53.1,+ORDER,"DSS")) Q:'CL!'$P(CL,"^",2)
 S DIC="^PS(53.46,",DIC(0)="NSUZX",X=+CL D ^DIC Q:(Y>0)
 ;
 S DIC="^SC(",DIC(0)="NSUXZ",X=+CL D ^DIC Q:'$G(Y)
 S CLNM=$P(Y,"^",2)
 S PSJMARR(1,0)=" The following location is not defined in the CLINIC DEFINITION (#53.46) file:"
 S PSJMARR(3,0)="   Location.......: "_CLNM
 S PSJMARR(4,0)=" As a result, the following Clinic Order will not display in BCMA:"
 S PSJMARR(5,0)="   Patient DFN....: "_DFN
 S PSJMARR(6,0)="   Order Number...: "_ORDER,PSJMARR(7,0)=""
 S MSG2=" Clinic Orders associated with "_CLNM_" will not display in BCMA unless the clinic is defined in the CLINIC DEFINITION (#53.46) file, and the SEND TO BCMA (#3) field is set to YES."
 D TXT^PSGMUTL(MSG2,74)
 S I="" F  S I=$O(MARX(I)) Q:I=""  S PSJMARR(7+I,0)=" "_MARX(I)
 D MSGEN(.PSJMARR)
 K %
 Q
MSGEN(PSJCLMSG) ; Begin
 D SENDMSG
 Q
SENDMSG ;Send mail message
 K PSG,XMY S XMDUZ="MEDICATIONS,INPATIENT",XMSUB="INCOMPLETE CLINIC DEFINITION SETUP",XMTEXT="PSGCL(",XMY("G.PSJ CLINIC DEFINITION")="" D NOW^%DTC S Y=% X ^DD("DD")
 N I S I="" F  S I=$O(PSJCLMSG(I)) Q:I=""  S PSGCL(I,0)=$G(PSJCLMSG(I,0))
 D ^XMD
 ;
DONE ;
 K DA,DIK,X,XMDUZ,XMSUB,XMTEXT,XMY,Y,PSGCL,MARX,XMDUN,XMMG,XMZ
 Q
 ;
GETDT ; check date/time for job to run
 N %DT,Y S %DT="NRS"
 D ^%DT I Y=-1 K X
 E  S X=Y
 Q
CON() ;
 N %DT S %DT="NRS" D ^%DT
 Q Y
 ;
CWARN(DFN,ORDER) ; Display warning about undefined CLINIC DEFINITION
 Q:'$G(DFN)!'$G(ORDER)  Q:'(ORDER["P")
 N I,MARX,MSG1,I,CL,CLNM,DIC,X,Y
 S CL=$G(^PS(53.1,+ORDER,"DSS")) Q:'CL!'$P(CL,"^",2)
 S DIC="^PS(53.46,",DIC(0)="NSUZX",X=+CL D ^DIC Q:(Y>0)
 S DIC="^SC(",DIC(0)="NSUXZ",X=+CL D ^DIC Q:'$G(Y)
 S CLNM=$P(Y,"^",2)
 D CLEAR^VALM1,FULL^VALM1
 S MSG1="Clinic "_CLNM_" is not defined in the CLINIC DEFINITION (#53.46) file."
 D TXT^PSGMUTL(MSG1,70)
 W ! S I="" F  S I=$O(MARX(I)) Q:I=""  W !,MARX(I)
 W !!,"This order will NOT display in BCMA, unless the clinic is defined in the"
 W !,"CLINIC DEFINITION (#53.46) file, and the SEND TO BCMA (#3) field is set to YES."
 W !!,"Please contact your Pharmacy ADPAC.",!
 D CONT^PSJOE0
 Q
