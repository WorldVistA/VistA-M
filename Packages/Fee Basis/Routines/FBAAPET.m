FBAAPET ;AISC/DMK-EDIT PAYMENT ;7/13/2003
 ;;3.5;FEE BASIS;**4,38,55,61,77,116**;JAN 30, 1995;Build 30
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 S FBOT=1
GETPT I $G(BAT) D
 .I '$D(^FBAAC("AC",+BAT)) F I=9,10,11 S $P(^FBAA(161.7,+BAT,0),U,I)=""
 .I $D(^FBAAC("AC",+BAT)) D  S $P(^FBAA(161.7,+BAT,0),U,11)=I,$P(^(0),U,9)=$G(FBTOT) K I,FBTOT
 ..N J,K,L,M S (I,J,K,L,M,FBTOT)=0
 ..F  S J=$O(^FBAAC("AC",+BAT,J)) Q:'J  F  S K=$O(^FBAAC("AC",+BAT,J,K)) Q:'K  F  S L=$O(^FBAAC("AC",+BAT,J,K,L)) Q:'L  F  S M=$O(^FBAAC("AC",+BAT,J,K,L,M)) Q:'M  I $D(^FBAAC(J,1,K,1,L,1,M,0)) S I=I+1,FBTOT=FBTOT+$P(^(0),U,3)
 W !! S DIC="^FBAAC(",DIC(0)="AEQM" D ^DIC G END:X="^"!(X=""),GETPT:Y<0 S (DFN,FBDA(3))=+Y
 S:'$D(^FBAAC(DFN,1,0)) ^FBAAC(DFN,1,0)="^162.01P^0^0"
 S DIC=DIC_DFN_",1,"
GETVD W !! S DIC(0)="AEQM" D ^DIC G GETPT:X="^"!(X=""),GETVD:Y<0 S (FBV,FBVD,FBDA(2))=+Y
 S:'$D(^FBAAC(DFN,1,FBDA(2),1,0)) ^FBAAC(DFN,1,FBDA(2),1,0)="^162.02DA^0^0"
 S DIC=DIC_FBVD_",1,"
GETDT S DIC(0)="AEQM",DIC("A")="Date of Service: " D ^DIC K DIC("A") G GETPT:X="^"!(X=""),GETDT:Y<0 S (FBSD,FBSDI,FBDA(1))=+Y,FBAADT=$P(Y,U,2)
 S:'$D(^FBAAC(DFN,1,FBDA(2),1,FBDA(1),1,0)) ^FBAAC(DFN,1,FBDA(2),1,FBDA(1),1,0)="^162.03A^0^0"
 S FBZ=DIC_FBSD_",1,"
SERV S DA(3)=FBDA(3),DA(2)=FBDA(2),DA(1)=FBDA(1)
 S DIC("W")="N FBX S FBX=$$MODL^FBAAUTL4(""^FBAAC(FBDA(3),1,FBDA(2),1,FBDA(1),1,+Y,""""M"""")"",""E"") W:FBX]"""" ""    CPT Modifier(s): "",FBX Q"
 S DIC=FBZ,DIC(0)="AEQMZ"
 D
 . N ICPTVDT S ICPTVDT=$G(FBAADT) D ^DIC
 G GETPT:X="^"!(X=""),SERV:Y<0 S (FBSV,FBAACPI,FBDA)=+Y,BAT=$P(Y(0),U,8),FBDUZ=$P(Y(0),U,7),(FBAACP,FBAACP(0))=$P(Y,U,2),K=$P(Y(0),U,3),FBAAPTC=$P(Y(0),U,20),J(0)=$P(Y(0),U,2)
 ; set FB1725 true (1) if payment is for a Mill Bill claim
 S FB1725=$S($P(Y(0),U,13)["FB583":+$P($G(^FB583(+$P(Y(0),U,13),0)),U,28),1:0)
 I FBDUZ'=DUZ&('$D(^XUSEC("FBAASUPERVISOR",DUZ))) W !!,*7,"Sorry,only the clerk who entered the payment ",!," or a supervisor can edit this payment." G GETPT
 S FBAAMM1=$P($G(^FBAAC(FBDA(3),1,FBDA(2),1,FBDA(1),1,FBDA,2)),U,2)
 S FBFSAMT(0)=$P($G(^FBAAC(FBDA(3),1,FBDA(2),1,FBDA(1),1,FBDA,2)),U,12)
 ; determine lesser of original fee schedule amount and amount claimed
 S FBAMTPD(0)=$S(FBFSAMT(0)="":J(0),FBFSAMT(0)>J(0):J(0),1:FBFSAMT(0))
 S FBMODL=$$MODL^FBAAUTL4("^FBAAC("_FBDA(3)_",1,"_FBDA(2)_",1,"_FBDA(1)_",1,"_FBDA_",""M"")")
 ; load current adjustment data
 D LOADADJ^FBAAFA(FBDA_","_FBDA(1)_","_FBDA(2)_","_FBDA(3)_",",.FBADJ)
 ; save adjustment data prior to edit session in sorted list
 S FBADJL(0)=$$ADJL^FBUTL2(.FBADJ) ; sorted list of original adjustments
 ; load current remittance remark data
 D LOADRR^FBAAFR(FBDA_","_FBDA(1)_","_FBDA(2)_","_FBDA(3)_",",.FBRRMK)
 ; save remittance remarks prior to edit session in sorted list
 S FBRRMKL(0)=$$RRL^FBUTL4(.FBRRMK)
 ; save FPPS data prior to edit session
 S FBFPPSC(0)=$P($G(^FBAAC(FBDA(3),1,FBDA(2),1,FBDA(1),1,FBDA,3)),U)
 S FBFPPSC=FBFPPSC(0)
 S FBFPPSL(0)=$P($G(^FBAAC(FBDA(3),1,FBDA(2),1,FBDA(1),1,FBDA,3)),U,2)
 S FBFPPSL=FBFPPSL(0)
 G:BAT']"" EDIT
 I $G(^FBAA(161.7,BAT,"ST"))]"",$P(^FBAA(161.7,BAT,"ST"),"^")="S"!($P(^FBAA(161.7,BAT,"ST"),"^")="T")&('$D(^XUSEC("FBAASUPERVISOR",DUZ))) W !!,*7,"Sorry, only the Supervisor can edit a payment once the batch has been released." G GETPT
 I $G(^FBAA(161.7,BAT,"ST"))]"",$P(^FBAA(161.7,BAT,"ST"),"^")="V" W !!,*7,"Sorry,you cannot edit a payment once the batch has been Finalized." G GETPT
EDIT S DA=FBSV
 ;
 ; first edit CPT code and modifiers
 D CPTM^FBAALU(FBAADT,DFN,FBAACP(0),FBMODL) I '$G(FBGOT) G GETPT
 ; if CPT was changed then update file
 I FBAACP'=FBAACP(0) D  I FBAACP="@" G GETPT
 . N FBIENS,FBFDA
 . S FBIENS=FBDA_","_FBDA(1)_","_FBDA(2)_","_FBDA(3)_","
 . S FBFDA(162.03,FBIENS,.01)=FBAACP
 . D FILE^DIE("","FBFDA") D MSG^DIALOG()
 ; if modifiers changed then update file
 I FBMODL'=$$MODL^FBAAUTL4("FBMODA") D REPMOD^FBAAUTL4(FBDA(3),FBDA(2),FBDA(1),FBDA)
 ;
 ; now edit remaining fields
 S DIE("NO^")=""
 S DR="48;47;S FBUNITS=X;42R;S FBZIP=X;S:$$ANES^FBAAFS($$CPT^FBAAUTL4(FBAACP)) Y=""@2"";43///@;S FBTIME=X;S Y=""@3"";@2;43R;S FBTIME=X;@3"
 ; fb*3.5*116 remove edit of interest indicator (162.03,34) to prevent different interest indicator values at line item level; interest indicator set at invoice level only; 
 ;S DR(1,162.03,1)="S FBAAMM=$S(FBAAPTC=""R"":"""",1:1);D PPT^FBAACO1(FBAAMM1);34///@;34////^S X=FBAAMM1;30R;S FBHCFA(30)=X;1;S J=X;Q"
 S DR(1,162.03,1)="30R;S FBHCFA(30)=X;1;S J=X;Q"
 S DR(1,162.03,2)="D FEEDT^FBAACO3;44///@;44///^S X=FBFSAMT;45///@;45///^S X=FBFSUSD;S:FBAMTPD'>0!(FBAMTPD=FBAMTPD(0)) Y=""@4"";2///^S X=FBAMTPD;@4;2//^S X=FBAMTPD;D CHKIT^FBAACO3;S K=X"
 ;S DR(1,162.03,3)="3////^S X=$S(J-K:J-K,1:"""");I X S Y=""@11"";4////@;S Y=""@5"";@11;3R;4R;S:X'=4 Y=""@5"";22"
 S DR(1,162.03,3)="K FBADJD;M FBADJD=FBADJ;S FBX=$$ADJ^FBUTL2(J-K,.FBADJ,2,,.FBADJD,1)"
 S DR(1,162.03,4)="S FBX=$$FPPSC^FBUTL5(1,FBFPPSC);S:FBX=-1 Y=0;S:FBX="""" Y=""@5"";50///^S X=FBX;S FBFPPSC=X;S FBX=$$FPPSL^FBUTL5(FBFPPSL);S:FBX=-1 Y=0;51///^S X=FBX;S FBFPPCL=X;S Y=""@55"";@5;50///@;S FBFPPSC="""";51///@;S FBFPPSL="""";@55"
 S DR(1,162.03,5)="K DIE(""NO^"");W !,""Exit ('^') allowed now"";26;S PRC(""SITE"")=X;8;13;Q;33;49"
 S DR(1,162.03,6)="15;17;16;S:X=1 Y=""@1"";@6;28R;S:$$INPICD9^FBCSV1(X,"""",$G(FBAADT)) Y=""@6"";31;32R;S Y=""@7"";@1;28;I X]"""" S:$$INPICD9^FBCSV1(X,"""",$G(FBAADT)) Y=""@1"";31"
 S DR(1,162.03,7)="@7;K FBRRMKD;M FBRRMKD=FBRRMK;S FBX=$$RR^FBUTL4(.FBRRMK,2,,.FBRRMKD)"
 S DIE=FBZ
 D
 . N ICPTVDT,ICDVDT S (ICPTVDT,ICDVDT)=$G(FBAADT) D ^DIE
 ; if adjustment data changed then file
 I $$ADJL^FBUTL2(.FBADJ)'=FBADJL(0) D FILEADJ^FBAAFA(FBDA_","_FBDA(1)_","_FBDA(2)_","_FBDA(3)_",",.FBADJ)
 ; if remit remark data changed then file
 I $$RRL^FBUTL4(.FBRRMK)'=FBRRMKL(0) D FILERR^FBAAFR(FBDA_","_FBDA(1)_","_FBDA(2)_","_FBDA(3)_",",.FBRRMK)
 ; if FPPS CLAIM ID changed, update other line items on invoice
 I FBFPPSC'=FBFPPSC(0) D
 . N FBAAIN
 . S FBAAIN=$$GET1^DIQ(162.03,FBDA_","_FBDA(1)_","_FBDA(2)_","_FBDA(3)_",",14)
 . D CKINVEDI^FBAAPET1(FBFPPSC(0),FBFPPSC,FBAAIN,FBDA_","_FBDA(1)_","_FBDA(2)_","_FBDA(3)_",")
 K FBSV W !! G SERV
END K DR,DIC,DIE,X,DFN,FBOT,FBVD,FBSD,BAT,FBAADT,FBSV,DA,FBDA,FBZ,FBDUZ,FBAACP,FBFY,FY,FBAMTPD,J,K,Y,ZZ,PRC,FBHOLDX,FBV,FBSDI,FBAACPI
 K FBFSAMT,FBFSUSD,FBMODA,FBZIP,FBTIME,FBHCFA(30),FBAAPTC,FB1725,FBADJ,FBADJD,FBADJL(0),FBRRMK,FBRRMKD,FBRRMKL(0),FBX,FBUNITS
 Q
