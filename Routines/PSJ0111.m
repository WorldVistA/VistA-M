PSJ0111 ;BIR/JLC - Check for Non-Standard Schedules ;01-MAR-04
 ;;5.0; INPATIENT MEDICATIONS ;**111**;16 DEC 97
 ;
 ;Reference to ^PS(51.1 is supported by DBIA# 2177.
 ;
 Q
SENDMSG ;Send mail message when check is complete.
 K PSG,XMY S XMDUZ="MEDICATIONS,INPATIENT",XMSUB="SCHEDULE FILE (#51.1)",XMTEXT="^XTMP(""PSJ"",1,",XMY("G.PHARMACY SCHEDULES@FO-BIRM.MED.VA.GOV")=""
 D NOW^%DTC S Y=% X ^DD("DD")
 S OCNT=0,A="^PS(51.1,0)" F  S A=$Q(@A) Q:A=""  Q:$P(A,",",2)'?1.N  S OCNT=OCNT+1,^XTMP("PSJ",1,OCNT)=A_" = "_@A
 D ^XMD
 Q
 ;
