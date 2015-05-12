FBAAPET ;AISC/DMK - EDIT PAYMENT ;5/16/12 12:44pm
 ;;3.5;FEE BASIS;**4,38,55,61,77,116,122,133,108,124,132,139,123**;JAN 30, 1995;Build 51
 ;;Per VA Directive 6402, this routine should not be modified.
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
 ;S FBAAMM1=$P($G(^FBAAC(FBDA(3),1,FBDA(2),1,FBDA(1),1,FBDA,2)),U,2)
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
 ; check batch status
 S FBSTAT=$P($G(^FBAA(161.7,BAT,"ST")),U) ; batch status
 I FBSTAT="S",'$D(^XUSEC("FBAASUPERVISOR",DUZ)) W !!,*7,"Sorry, only the Supervisor can edit a payment once the batch has been released." G GETPT
 I "^T^F^V^"[(U_FBSTAT_U) W !!,*7,"Sorry, you cannot edit a payment when the batch has been sent to Austin." G GETPT
 K FBSTAT
 ;
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
 ; Check for IPAC data requirements for Federal Vendors (FB*3.5*123)
 I '$$IPACEDIT^FBAAPET1(162.03,.FBDA) G SERV
 ;
 ; now edit remaining fields
 S DIE("NO^")=""
 ; FB*3.5*139-JLG-ICD10 REMEDIATION -added FBDXCHK1 and FBDXCHK2
 N FBDXCHK1 S FBDXCHK1="S:FBAADT<$$IMPDATE^FBCSV1(""10D"") Y=""@7"";@60;S XX1=-1 S XX1=$$ASKICD10^FBAACO2(FBAADT,""Y"") S:XX1<0 Y=""@60"";28////^S X=XX1;S Y=31;"
 N FBDXCHK2 S FBDXCHK2="S:FBAADT<$$IMPDATE^FBCSV1(""10D"") Y=""@8"";@15;S XX1=-1 S XX1=$$ASKICD10^FBAACO2(FBAADT) S:XX1<0 Y=""@15"";28////^S X=XX1;S Y=31;"
 S DR="48;47;S FBUNITS=X;42R;S FBZIP=X;S:$$ANES^FBAAFS($$CPT^FBAAUTL4(FBAACP)) Y=""@2"";43///@;S FBTIME=X;S Y=""@3"";@2;43R;S FBTIME=X;@3"
 ; fb*3.5*116 remove edit of interest indicator (162.03,34) to prevent different interest indicator values at line item level; interest indicator set at invoice level only; 
 S DR(1,162.03,1)="S FBAAMM=$S(FBAAPTC=""R"":"""",1:1);D PPT^FBAACO1(FBAAMM1,FBCNTRP,1);54///@;54////^S X=FBCNTRP;30R;S FBHCFA(30)=X;1;S J=X;Q"
 ;S DR(1,162.03,1)="30R;S FBHCFA(30)=X;1;S J=X;Q"
 S DR(1,162.03,2)="D FEEDT^FBAACO3;44///@;44///^S X=FBFSAMT;45///@;45///^S X=FBFSUSD;S:FBAMTPD'>0!(FBAMTPD=FBAMTPD(0)) Y=""@4"";2///^S X=FBAMTPD;@4;2//^S X=FBAMTPD;D CHKIT^FBAACO3;S K=X"
 ;S DR(1,162.03,3)="3////^S X=$S(J-K:J-K,1:"""");I X S Y=""@11"";4////@;S Y=""@5"";@11;3R;4R;S:X'=4 Y=""@5"";22"
 S DR(1,162.03,3)="K FBADJD;M FBADJD=FBADJ;S FBX=$$ADJ^FBUTL2(J-K,.FBADJ,2,,.FBADJD,1)"
 S DR(1,162.03,4)="S FBX=$$FPPSC^FBUTL5(1,FBFPPSC);S:FBX=-1 Y=0;S:FBX="""" Y=""@5"";50///^S X=FBX;S FBFPPSC=X;S FBX=$$FPPSL^FBUTL5(FBFPPSL);S:FBX=-1 Y=0;51///^S X=FBX;S FBFPPCL=X;S Y=""@55"";@5;50///@;S FBFPPSC="""";51///@;S FBFPPSL="""";@55"
 S DR(1,162.03,5)="K DIE(""NO^"");W !,""Exit ('^') allowed now"";26;S PRC(""SITE"")=X;8;@13;13;I $$BADDATE^FBAAPET(FBAADT,X) S Y=""@13"";Q;33;49"
 ;JAS - 09/11/13 - PATCH 139 - Modified next two lines (previously one line) for ICD-10
 S DR(1,162.03,6)="15;17;16;S:X=1 Y=""@1"";@6;"_FBDXCHK1_"@7;S FBI9=$$ASKICD9^FBAACO2(FBAADT,""Y"") S:+FBI9<0 Y=""@7"";28////^S X=+FBI9;31;32R;S Y=""@9"";"
 S DR(1,162.03,7)="@1;"_FBDXCHK2_"@8;S FBI9=$$ASKICD9^FBAACO2(FBAADT) S:+FBI9<0 Y=""@8"";28////^S X=+FBI9;31"
 S DR(1,162.03,8)="@9;K FBRRMKD;M FBRRMKD=FBRRMK;S FBX=$$RR^FBUTL4(.FBRRMK,2,,.FBRRMKD)"
 S DR(1,162.03,9)="73;74;75;58;59;60;61;62;63;64;65;66;67;76;77;78;79;68;69" ;FB*3.5*122,FB*3.5*133 edit line item provider fields
 S DR(1,162.03,10)="@999;K FBDXCHK1,FBDXCHK2,XX1"  ;DEM;139 ICD-10 ASF
 S DIE=FBZ
 D
 . N ICPTVDT,ICDVDT,FB583,FBAAMM,FBAAMM1,FBCNTRA,FBCNTRP,FBVEN,FTP
 . S (ICPTVDT,ICDVDT)=$G(FBAADT)
 . ; set variables for call to PPT^FBAACO1
 . S FBAAMM1=$P($G(^FBAAC(FBDA(3),1,FBDA(2),1,FBDA(1),1,FBDA,2)),U,2)
 . S FBCNTRP=$P($G(^FBAAC(FBDA(3),1,FBDA(2),1,FBDA(1),1,FBDA,3)),U,8)
 . S X=$P($G(^FBAAC(FBDA(3),1,FBDA(2),1,FBDA(1),1,FBDA,0)),U,13)
 . S:X[";FB583(" FB583=+X
 . S FTP=$P($G(^FBAAC(FBDA(3),1,FBDA(2),1,FBDA(1),0)),U,4)
 . S FBVEN=$S(FTP:$P($G(^FBAAA(DFN,1,FTP,0)),U,4),1:"")
 . S FBCNTRA=$S(FTP:$P($G(^FBAAA(DFN,1,FTP,0)),U,22),1:"")
 . D ^DIE
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
 ;
BADDATE(FBDOS,INVRCVDT) ;Reject entry if InvRcvDt is Prior to the Date of Service on the Invoice
 I INVRCVDT<FBDOS D  Q 1 ;Reject entry
 .N SHOWDOS S SHOWDOS=$E(FBDOS,4,5)_"/"_$E(FBDOS,6,7)_"/"_$E(FBDOS,2,3) ;Convert FBDOS into display format for error message
 .W *7,!!?5,"*** Invoice Received Date cannot be prior to the",!?8,"Date of Service ("_SHOWDOS_") !!!"
 Q 0 ;Accept entry
 ;
END K DR,DIC,DIE,X,DFN,FBOT,FBVD,FBSD,BAT,FBAADT,FBSV,DA,FBDA,FBZ,FBDUZ,FBAACP,FBFY,FY,FBAMTPD,J,K,Y,ZZ,PRC,FBHOLDX,FBV,FBSDI,FBAACPI
 K FBFSAMT,FBFSUSD,FBMODA,FBZIP,FBTIME,FBHCFA(30),FBAAPTC,FB1725,FBADJ,FBADJD,FBADJL(0),FBRRMK,FBRRMKD,FBRRMKL(0),FBX,FBUNITS
 Q
