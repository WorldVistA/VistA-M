PSOERXA0 ;ALB/BWF - eRx Utilities/RPC's ; 8/3/2016 5:14pm
 ;;7.0;OUTPATIENT PHARMACY;**467,586**;DEC 1997;Build 3
 ;
 Q
 ; All parameters are optional, however at least one needs to be passed in for processing to be sucessful.
 ; NDCUPN - This is the NDC/UPN for the drug (optional)
 ; DGDESC - Drug description (optional)
DRGMTCH(PSORES,NDCUPN,DGDESC) ;
 N VAPRID,NDCUPNT,NDCUPNV,NDCUXREF,NUIEN,NDCERR,PSMIEN,NDCERR,PSDRG,PSDRGCNT,PSDGLST,I
 S (PSORES,NDCERR)=0
 I $G(DGDESC)]"" D
 .S DGDESC=$$UP^XLFSTR(DGDESC)
 .I $D(^PSDRUG("B",DGDESC)) D
 ..S (PSDRG,PSDRGCNT)=0 F  S PSDRG=$O(^PSDRUG("B",DGDESC,PSDRG)) Q:'PSDRG  D
 ...I '$$ACTIVE(PSDRG)!('$$OUTPAT(PSDRG))!($$INVCOMP(PSDRG))!($$CS(PSDRG)) Q
 ...S PSDRGCNT=PSDRGCNT+1,PSDGLST(PSDRG)=""
 ..I PSDRGCNT>1 S PSORES="0^More than one possible drug match found. Pharmacist review required."
 ..I PSDRGCNT=1 S PSMIEN=$O(^PSDRUG("B",DGDESC,0)),PSORES=PSMIEN_U_$$GET1^DIQ(50,PSMIEN,.01,"E") Q
 .I $D(^PSNDF(50.68,"B",DGDESC)) S VAPRID=$O(^PSNDF(50.68,"B",DGDESC,0)) Q
 .; is it possible to have more than one drug or va product match here? .01 fields are unique!
 ; direct match in DRUG file
 I $P(PSORES,U)>1 Q
 ; direct match in VA PRODUCT file
 I $G(VAPRID) D VAPRID(.PSORES,VAPRID) I $P(PSORES,U) Q
 I $G(NDCUPN)']"",$P(PSORES,U,2)]"" Q
 ; check the NDC/UPN if passed in
 I $G(NDCUPN)]"" D
 .S NDCUPNT=$P(NDCUPN,U),NDCUPNV=$P(NDCUPN,U,2),NDCUXREF=$S(NDCUPNT="N":"NDC",NDCUPNT="U":"UPN",1:"")
 .; if NDC is less than 12 in length, pad front with zeros until a length of 12 is achieved.
 .I NDCUPNT="N",$L(NDCUPNV)<12 D
 ..F I=1:1:12-$L(NDCUPNV) S NDCUPNV=0_NDCUPNV
 .S NUIEN=$O(^PSNDF(50.67,NDCUXREF,NDCUPNV,0)) I 'NUIEN S NDCERR=1 Q
 .S VAPRID=$$GET1^DIQ(50.67,NUIEN,5,"I")
 .I VAPRID D VAPRID(.PSORES,VAPRID)
 I $P(PSORES,U) Q
 I $G(NDCERR) S PSORES="0^NDC/UPN match not found." Q
 I $P(PSORES,U)=0 S PSORES="0^No matches found."
 Q
VAPRID(PSORES,VAPID) I '$G(VAPRID) S PSORES="0^No VA PRODUCT associated with this NDC/UPN." Q
 N VAPMTCH,VAPCNT,VAPDRG,PSODRG
 S (VAPMTCH,VAPCNT)=0 F  S VAPMTCH=$O(^PSDRUG("APR",VAPRID,VAPMTCH)) Q:'VAPMTCH  D
 .; ONLY GET MEDICATIONS FOR OUTPATIENT USE, AND ARE NOT MARKED INACTIVE
 .I '$$OUTPAT(VAPMTCH)!('$$ACTIVE(VAPMTCH))!($$INVCOMP(VAPMTCH))!($$CS(VAPMTCH)) Q
 .S VAPDRG(VAPMTCH)="",VAPCNT=VAPCNT+1
 I VAPCNT=1 S PSODRG=$O(VAPDRG(0)),PSORES=PSODRG_U_$$GET1^DIQ(50,PSODRG,.01,"E") Q
 I VAPCNT>1 S PSORES="0^Multiple matched drugs found. Pharmacist review required." Q
 Q
 ; active drug check
ACTIVE(DIEN) ;
 N INACTDT
 S INACTDT=$P($G(^PSDRUG(DIEN,"I")),U) I INACTDT,INACTDT<DT Q 0
 Q 1
 ; check to see if this is drug is marked for outpatient use
OUTPAT(DIEN) ;
 I $P($G(^PSDRUG(DIEN,2)),U,3)["O" Q 1
 Q 0
 ; check to see if the drug is investigational or compond
INVCOMP(DIEN) ;
 N X
 S X=$P($G(^PSDRUG(DIEN,0)),U,3)
 ; if a supply, not controlled substance
 I X="S" Q 0
 I X["I"!(X["0")!(X["M") Q 1
 Q 0
CS(DIEN) ;
 N X
 S X=$P($G(^PSDRUG(DIEN,0)),U,3)
 I X["S" Q 0
 I X]"",(X["1")!(X["2")!(X["3")!(X["4")!(X["5") Q 1   ; PSO*7*586
 Q 0
CHKSTR() ;
 Q
TPRVMTCH ;
 N X,Y,TRES
 S X="" F  S X=$O(^VA(200,"PS1",X)) Q:X=""  D
 .S Y=0 F  S Y=$O(^VA(200,"PS1",X,Y)) Q:'Y  D
 ..K TRES D PRVMTCH(.TRES,"",X) I $P(TRES,U)=0 W !,TRES_" "_X Q
 ..I $P(TRES,U) W !,X,?20,$$GET1^DIQ(200,Y,.01,"E")
 Q
 ; Match provider given NPI, DEA, or provider name.
 ; NPI - NPI value for the provider
 ; DEA - Providers' DEA number
 ; CS - controlled substance (1-yes, 0 or "" - no)
PRVMTCH(PSORES,NPI,DEA,CS) ;
 N NPIEN,MATCH,VAL,NVAL,INDEX,NPCNT,NPLIST,DEACNT,SRCH,DEACNT,DEAMTCH,NDMTCH,DEAIEN
 N DEACHK
 S (PSORES,MATCH)=0
 S NPI=$G(NPI,""),DEA=$G(DEA,"")
 I NPI="",DEA="" S PSORES="0^NPI and DEA# missing." Q
 I $G(CS),DEA="" S PSORES="0^DEA # must be provided with controlled substances." Q
 I $G(CS),NPI="" S PSORES="0^NPI must be provided with controlled substances." Q
 I $G(CS),'$D(^VA(200,"ANPI",NPI)) S PSORES="0^NPI# does not exist in this system." Q
 I $G(CS),'$D(^VA(200,"PS1",DEA)) S PSORES="0^DEA# does not exist in this system." Q
 I '$G(CS),NPI="" D  Q
 .I DEA="" S PSORES="0^Missing DEA number." Q
 .I '$D(^VA(200,"PS1",DEA)) S PSORES="0^DEA# does not exist at this location." Q
 .S (DEACHK,DEACNT)=0 F  S DEACHK=$O(^VA(200,"PS1",DEA,DEACHK)) Q:'DEACHK  D
 ..S DEACNT=$G(DEACNT)+1
 .I DEACNT>1 S PSORES="0^Multiple DEA matches found." Q
 .I DEACNT=1 S DEAIEN=$O(^VA(200,"PS1",DEA,0))
 .I '$$MEDAUTH(DEAIEN) S PSORES="0^DEA match, not authorized to write medication orders." Q
 .S PSORES=DEAIEN_U_$$GET1^DIQ(200,DEAIEN,.01,"E")
 I '$D(^VA(200,"ANPI",NPI)) S PSORES="0^No matching NPI." Q
 ; get a list of providers that match the NPI#
 S (NPIEN,NPCNT)=0 F  S NPIEN=$O(^VA(200,"ANPI",NPI,NPIEN)) Q:'NPIEN  D
 .S NPLIST(NPIEN)="",NPCNT=$G(NPCNT)+1
 ; no matches
 I '$D(NPLIST) S PSORES="0^Could not match provided NPI." Q
 I '$G(CS),NPCNT>1 S PSORES="0^Multiple provider matches found." Q
 I NPCNT=0 S PSORES="0^No NPI match found." Q
 I '$G(CS),NPCNT=1 D  Q
 .S NDMTCH=$O(NPLIST(0))
 .I '$$MEDAUTH(NDMTCH) S PSORES="0^NPI match found, not authorized to write medication orders." Q
 .S PSORES=NDMTCH_U_$$GET1^DIQ(200,$O(NPLIST(0)),.01,"E")
 ; if this is a controlled substance, we must match both the NPI and the DEA#
 S (SRCH,DEACNT)=0 F  S SRCH=$O(NPLIST(SRCH)) Q:'SRCH  D
 .I '$D(^VA(200,"PS1",DEA,SRCH)) Q
 .S DEAMTCH(SRCH)="",DEACNT=$G(DEACNT)+1
 I DEACNT>1 S PSORES="0^Multiple DEA matches found." Q
 I DEACNT=0 S PSORES="0^NPI match, DEA mismatch." Q
 S NDMTCH=$O(DEAMTCH(0))
 I '$$MEDAUTH(NDMTCH) S PSORES="0^NPI/DEA match, not authorized to write medication orders." Q
 I NDMTCH S PSORES=NDMTCH_U_$$GET1^DIQ(200,NDMTCH,.01,"E") Q
 S PSORES="0^Matching procedure completed with no results."
 Q
 ; ensure the dea# is active
DEACTIVE(USER) ;
 N EXPDT
 S EXPDT=$$GET1^DIQ(200,USER,747.44,"I")
 I EXPDT,EXPDT<DT Q 0
 Q 1
 ; check to ensure the provider is authorized to write med orders
MEDAUTH(USER) ;
 Q $$GET1^DIQ(200,USER,53.1,"I")
