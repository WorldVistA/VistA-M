PSNPPSNW ;HP/MJE-PPSN update NDF data additional update code ; 05 Mar 2014  1:20 PM
 ;;4.0;NATIONAL DRUG FILE;**513,563,569**; 30 Oct 98;Build 3
 ;
 ;Reference to ^PSSREF supported by DBIA #6371
 ;Reference to ^PSDRUG supported by DBIA #221
 ;Reference to ^PSSUTIL supported by DBIA #3107
 ;Reference to ^PS(59.7 supported by DBIA #2613
 ;
REMATCH(DA,PSNFNM) ;called by PSNPPSNU
 ;DA & DISPDRG are both local drug IEN
 ;PSNFNM is IEN of NDF (50.68) entry to match to
 N DISPDRG S DISPDRG=""
 ;
 S DISPDRG=DA
 ;-vvvvvvvvv- from PSSDEE -vvvvvvvvv-
 ;
 N FLGNDF,K,NEWDF,NFI,NFR,NWND,NWPC1,NWPC3,OLDDF,PSNCLASS,PSNFL,PSNLOC,PSNNDF,PSNNEW,PSNOLD,PSNP,PSNPST,PSNSIZE
 N PSNTYPE,PSNVADC,PSNW,VAID,REC
ASKND ;  
 D RSET,EN1(PSNFNM,DA)
 D REACT S DA=DISPDRG I $D(^PSDRUG(DA,"ND")),$P(^PSDRUG(DA,"ND"),"^",2)]"" D
 .S PSNP=$G(^PSDRUG(DA,"I")) I PSNP,PSNP<DT Q
 .S NWND=^PSDRUG(DA,"ND"),NWPC1=$P(NWND,"^",1),NWPC3=$P(NWND,"^",3),DA=NWPC1,K=NWPC3 S X=$$PSJDF^PSNAPIS(DA,K) S NEWDF=$P(X,"^",2),DA=DISPDRG
 .; changed PSSUTIL call 2nd argument to use 0 instead of 1 ('quiet' mode)
 .D EN2^PSSUTIL(DISPDRG,0) S:'$D(OLDDF) OLDDF="" I OLDDF'=NEWDF S FLGNDF=1
 .N X,Y,Z D
 ..S X=$P($G(^PSDRUG(DISPDRG,0)),"^") Q:X=""
 ..S Y=$G(^PSNDF(50.68,PSNFNM,1)),Z=$P(Y,"^",2),Y=$P(Y,"^")
 ..S ^TMP($J,"REMATCHED",X)=Y_"^"_Z_"^"_DISPDRG_"^"_PSNFNM
 Q
 ;
 ;-vvvvvvvvv- from PSSDEE1 -vvvvvvvvv-
 ;
RSET ;
 S:$D(^PSDRUG(DA,"ND")) PSNID=$P(^PSDRUG(DA,"ND"),"^",10)
 S PSNP=$G(^PSDRUG(DA,"I")) I PSNP,PSNP<DT Q:$D(^PSDRUG(DA,"I"))
 S DA=DISPDRG D UNMDRUG^PSSUTIL(DA) S:$D(^PSDRUG(DA,3)) $P(^PSDRUG(DA,3),"^",1)=0 K:$D(^PSDRUG("AQ",DA)) ^PSDRUG("AQ",DA)
 I $D(PSNID),PSNID]"" K PSNID
 D ^PSSREF ; *OK
 Q
 ;
 ;-vvvvvvvvv- from PSSUTIL -vvvvvvvvv-
 ;
EN1(PSNDIEN,PSN50IEN) ;Receive Drug entries that have been unmatched
 N PSSLD,PSSPWXEX,X,DIC,DA
 I PSNPS="N" S DIC="^NDFK(5000.2,",DIC(0)="LMXZ",X="",X=PSNDIEN K DD,DO D FILE^DICN D ERROR^PSNPPSNU:$D(ERROR("DIERR"))
 Q:PSN50IEN=""
 K ^PSDRUG(PSN50IEN,"DOS"),^PSDRUG(PSN50IEN,"DOS1")
 K ^PSDRUG(PSN50IEN,"DOS2")
 Q
 ;
 ;-vvvvvvvvv- from PSNOUT -vvvvvvvvv-
 ;
REACT ; code for reactivation of inactive drug in local drug file
 I $O(^PSNDF(50.6,0)) S XX=$S('$D(^PSDRUG(DA,"ND")):1,1:$P(^("ND"),"^",2)="") I XX D
 .;BLDIT^PSNCOMP is the heart of the matching, GONE is okay
 .S (PSNB,PSNDRG,Z9)=DA,PSNLOC=$P(^PSDRUG(PSNB,0),"^",1) K ^PSNTRAN(PSNB) D GONE^PSNDRUG,BLDIT
 .;CHK is below (needs cleaning - DONE), SET^PSNMRG & GONE are okay
 .S DA=Z9 D CHK(DA),SET^PSNMRG,GONE^PSNDRUG K Z9,XX
 Q
 ;
 ;-vvvvvvvvv- from PSNCOMP -vvvvvvvvv-
 ;
BLDIT ; START ATTEMPT TO MATCH
 Q:'$D(^PSDRUG(PSNB,0))  Q:$P(^PSDRUG(PSNB,0),"^",1)']""
 I $D(^PSDRUG(PSNB,"ND")),$P(^PSDRUG(PSNB,"ND"),"^",2)]"" Q
 I $D(PSNFLB),$D(^PSNTRAN(PSNB,0)) Q
 S XX=PSNFNM D KILL^PSNHIT S PSNFNM=XX K XX
 ;*****  next line:  DEA check: implemented silent
 D  Q:$D(PSNINACT)  Q:'$D(PSNDEA)  K PSNDEA
 .K PSNINACT I $D(^PSDRUG(PSNB,"I")),$P(^PSDRUG(PSNB,"I"),"^",1)]"" S:+^PSDRUG(PSNB,"I")<DT PSNINACT=1
 .S PSNDEA=$P(^PSDRUG(PSNB,0),"^",3)
 .F VV=0,"I","M" I PSNDEA[VV S ^PSNTRAN(PSNB,0)="0^^^^^^^"_DUZ K VV,PSNDEA Q
 .K VV Q
 S PSNSIZE=$O(^PS(50.609,"B","OTHER",0)),PSNTYPE=$O(^PS(50.608,"B","OTHER",0))
 S PSNNDF=$P(^PSNDF(50.68,PSNFNM,0),"^",2),PSNCLASS=$P(^PSNDF(50.68,PSNFNM,3),"^") ; GEN NM, CLASS
 D SET
 Q
 ;-vvvvvvvvv- from PSNHIT -vvvvvvvvv- sets the match in ^PSNTRAN to be verified
 ;
SET S:'$D(^PSNTRAN(PSNB,0)) $P(^PSNTRAN(0),"^",4)=($P(^PSNTRAN(0),"^",4))+1,$P(^PSNTRAN(0),"^",3)=PSNB
 S ^PSNTRAN(PSNB,0)=PSNNDF_"^"_PSNFNM_"^"_PSNCLASS_"^^"_PSNSIZE_"^^"_PSNTYPE_"^"_DUZ ;D PKI W:$D(IOF) @IOF 
 S:'$D(PSNFL) PSNFL=0
 Q
 ;
 ;
 ;-vvvvvvvvv- from PSNVFY -vvvvvvvvv-
 ;
CHK(PSNB) ; 
 I $D(PSNFL) Q:PSNFL
 S PSNP=$G(^PSDRUG(PSNB,"I")) I PSNP,PSNP<DT K ^PSNTRAN(PSNB,0) Q
 Q:'$D(^PSNTRAN(PSNB,0))  Q:$P(^PSNTRAN(PSNB,0),"^",9)="Y"  Q:'$P(^PSNTRAN(PSNB,0),"^",2)
 S PSNPST=^PSNTRAN(PSNB,0),PSNOLD=$P(^PSDRUG(PSNB,0),U),PSNNEW=$P(^PSNDF(50.68,$P(PSNPST,"^",2),0),"^")
 ; condensed from START^PSNVFY
 S PSNW=1
 S PSNVADC=$P(^PSNTRAN(PSNB,0),"^",3)
 S NFI=$P($G(^PSNDF(50.68,PSNFNM,5)),"^"),NFR=$P($G(^PSNDF(50.68,PSNFNM,6,1,0)),"^")
 S $P(^PSNTRAN(PSNB,0),"^",9)="Y",$P(^PSNTRAN(PSNB,0),"^",10)=DUZ
 Q
 ;
REPORT ;
 ;take data from ^TMP($J,"REMATCHED",GN_NM)= VA_PRT_NM ^ VA_PROD_ID
 ;and put it into ^TMP("PSN PPSN PARSED",$J,"MESSAGE3",...
 N NM,VANM,PSNDISPD,PSNVPRD,PSNVPRDN
 N X S X="PPS-N Update File: "_$P(PSNHLD,";",1) D ADDLINE(X) S X="" D ADDLINE(X) ;add blank line after file name
 I '$D(^TMP($J,"REMATCHED")) D MSGHDR(1) Q
 D MSGHDR(0)
 N X S (VANM,NM)="" F  S NM=$O(^TMP($J,"REMATCHED",NM)) Q:NM=""  D
 .S VANM=$G(^TMP($J,"REMATCHED",NM)),VAID=$P(VANM,"^",2),PSNDISPD=$P(VANM,"^",3),PSNVPRD=$P(VANM,"^",4),VANM=$P(VANM,"^")
 .S PSNVPRDN=$$GET1^DIQ(50.68,PSNVPRD,.01)
 .S X="   "_NM_" ("_PSNDISPD_")" D ADDLINE(X)
 .S X="    RE-MATCHED TO" D ADDLINE(X)
 .S X="   "_VANM_"  ["_VAID_"]" D ADDLINE(X)
 .S X="      "_PSNVPRDN_" ("_PSNVPRD_")" D ADDLINE(X)
 .S X=" " D ADDLINE(X)
 K ^TMP($J,"REMATCHED")
 Q
 ;
MSGHDR(NONE) ;insert MESS3 header
 N I,X
 W !
 F I=1:1 S X="HDRTXT+"_I,X=$T(@X) S X=$P(X,";",3) Q:X=""  D
 .I 'NONE,X["[No re-matches]" Q
 .D ADDLINE(X)
 Q
 ;
ADDLINE(X) ;
 N C
 S (C,^TMP("PSN PPSN PARSED",$J,"MESSAGE3",0))=$G(^TMP("PSN PPSN PARSED",$J,"MESSAGE3",0))+1
 S ^TMP("PSN PPSN PARSED",$J,"MESSAGE3",C)=X
 Q
 ;
HDRTXT ;
 ;;The following local drug entries have been re-matched to the National Drug File based on the recommendations of the PPSN management group.;
 ;;If you do not agree with any of these re-matches you may re-match them locally.;
 ;; ;
 ;;   [No re-matches];
 ;;;
 ;
 ;=============================
 ;misc export stuff (unrelated)
 ;=============================
 Q
