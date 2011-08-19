MDPS3 ; HOIFO/NCA - Remote Data View Data Retriever for CP ;8/26/05  14:37
 ;;1.0;CLINICAL PROCEDURES;**2,5,13**;Apr 01, 2004;Build 19
 ; Integration Agreements:
 ; Reference IA# 2693 [Subscription] TIU Extractions.
 ;               3067 [Private] Read fields in Consult file (#123) w/FM
 ;               10104 [Supported] Routine XLFSTR calls.
 ;                 875 [Subscription] Access Order Status file (#100.01)
 ;
GET702(MDGLO,MDDFN,MDC,MDSDT,MDEDT,MDMAX) ; Gather the new 702 entries
 N MDARR,MDCON,MDDTE,MDLP,MDCODE,MDPROC,MDSTAT,MDX
 D GP^MDPS5(MDDFN,MDSDT,MDEDT)
 S MDLP="" F  S MDLP=$O(^MDD(702,"B",MDDFN,MDLP)) Q:MDLP<1  D
 .S MDX=$G(^MDD(702,MDLP,0)) Q:$P(MDX,"^",9)'=3
 .S MDPROC=$$GET1^DIQ(702,MDLP_",",.04,"E") Q:MDPROC=""
 .Q:'$P(MDX,U,6)
 .K ^TMP("MDTIUST",$J) S MDTIUER=""
 .D EXTRACT^TIULQ($P(MDX,U,6),"^TMP(""MDTIUST"",$J)",MDTIUER,".01;.05;70201;70202") Q:+MDTIUER
 .S MDCODE=$G(^TMP("MDTIUST",$J,$P(MDX,U,6),70201,"E"))
 .S:MDCODE'="" MDCODE=$$UP^XLFSTR(MDCODE)
 .I $G(MDC)'="" Q:MDCODE'=$G(MDC)
 .S MDDTE=$G(^TMP("MDTIUST",$J,$P(MDX,U,6),70202,"I"))
 .S MDSTAT=$G(^TMP("MDTIUST",$J,$P(MDX,U,6),.05,"E"))
 .S:'MDDTE MDDTE=$$GET1^DIQ(702,MDLP_",",.02,"I")
 .K ^TMP("MDTIUST",$J)
 .S MDCON=$P(MDX,U,5)
 .I +$G(MDSDT) Q:MDDTE<+$G(MDSDT)
 .I +$G(MDEDT) Q:MDDTE>+$G(MDEDT)
 .I MDCON D  Q:MDSTAT'="COMPLETE"&(MDSTAT'="PARTIAL RESULTS")
 ..S MDSTAT=$$GET1^DIQ(123,MDCON_",",8,"E")
 ..I MDSTAT="" S MDSTAT=$$GET1^DIQ(123,MDCON_",",8,"I") S:+MDSTAT MDSTAT=$$GET1^DIQ(100.01,MDSTAT_",",.01,"E")
 ..Q
 .S Y=MDDTE X ^DD("DD") N MDREV S MDREV=(9999999.9999-MDDTE)
 .I MDCON Q:$G(MDARR(MDCON))'=""  S MDARR(MDCON)=MDCON
 .S:$G(^TMP("MDPLST",$J,MDPROC,MDREV_"^"_MDLP))="" ^(MDREV_"^"_MDLP)=MDPROC_"^"_MDLP_"^"_"PR702"_"^"_"MDPS1"_"^^"_Y_"^"_MDCODE_"^^^^"_MDPROC_"^^"_MDCON_"^"_+$P(MDX,U,6)
 .Q
 K MDARR
 Q
PRO(RESULT) ;  Function to return info on single procedure.
 ;
 ; RESULT = variable pointer to a medicine file
 ;          (e.g. "12;MCAR(691.5,") (required)
 N MDVAL,LL,S3,S4,S5
 S S3=+RESULT,S4=$P(RESULT,";",2),S4=$P(S4,",")
 I S4="MCAR(702.7" Q ""
 I S4="MCAR(699" S LL=$P($G(^MCAR(699,+S3,0)),U,12),MDVAL=$P($G(^MCAR(697.2,+LL,0)),U) Q MDVAL
 I S4="MCAR(699.5" S LL=$P($G(^MCAR(699.5,+S3,0)),U,6),MDVAL=$P($G(^MCAR(697.2,+LL,0)),U) Q MDVAL
 I S4="MCAR(694" S LL=$P($G(^MCAR(699.5,+S3,0)),U,6),MDVAL=$P($G(^MCAR(697.2,+LL,0)),U) Q MDVAL
 S LL=$O(^MCAR(697.2,"C",S4,0)),MDVAL=$P(^MCAR(697.2,LL,0),U)
 Q MDVAL
CHKMED(MDCON) ; Check for Medicine results
 N MDCK,MDCX,MDY
 S MDY=0 D GETS^DIQ(123,MDCON_",","50*","I","MDCX")
 S MDCK="" F  S MDCK=$O(MDCX(123.03,MDCK)) Q:MDCK<1  S MDX4=$G(MDCX(123.03,MDCK,.01,"I")) D
 .I MDX4["MCAR" S MDY=1
 Q MDY
HDR ; Print Header for Report Form Feed
 N FFL,MDNM,MDNAME,MDTITL,MDTM S $P(FFL,"-",80)=""
 S MDNM=$QS(MDREC,4),MDNAME=$O(^MCAR(697.2,"B",MDNM,0))
 I MDNAME S MDTITL=$P($G(^MCAR(697.2,+MDNAME,0)),"^",8)
 I $G(MDTITL)="" S MDNAME=$O(^MDS(702.01,"B",MDNM,0)) S:MDNAME MDTITL=$P($G(^MDS(702.01,+MDNAME,0)),U)
 W !! D NOW^%DTC S X=% D DTIME^MCARP S MDTM=$$FMTE^XLFDT(X,2) K %
 S MDRPG=MDRPG+1 W !,"Pg. "_MDRPG_$J(" ",25)_$$HOSP^MDPS2(DFN)_$J(" ",25)_MDTM
 I $G(MDTITL)'="" W !,$J(" ",25)_MDTITL
 W !,$$DEMO^MDPS2(DFN)
 W !,FFL
 Q
