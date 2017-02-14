HMPWB5A ;JD/CNP - Write back entry points for Notes, and Encounters;Sep 2, 2015@08:44:47
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**2**;Sep 01, 2011;Build 28
 ;Per VA Directive 6402, this routine should not be modified.
 ;Continued from HMPWB5.
 ;
 Q
 ;
PCELST(TYPE,INPUT,OUTPUT,ERR) ;
 ;TYPE   = Encounter Type (e.g. CPT)
 ;INPUT  = Input array containing data for TYPE (the content varies based on what TYPE is)
 ;OUTPUT = Output array
 N CNT,HMP1,HMP2,HMPC,HMPD,HMPE,HMPF,HMPN,HMPP,HMPR,HMPS,HMPT,I,J,K,L
 S CNT=6,HMP1=0
 F  S HMP1=$O(INPUT(HMP1)) Q:HMP1'=+HMP1!($G(ERR)]"")  D
 .S HMP2=INPUT(HMP1),CNT=CNT+1,ERR="",HMPT=""
 .I TYPE="CPT" D
 ..;HMP2=CPT code^Modifier1 code;Modifier2 code;...^Quantity^Provider name^Comment
 ..S HMPN=$$UP^XLFSTR($P(HMP2,U))
 ..S HMPD=$O(^ICPT("B",HMPN,""))
 ..I HMPD'=+HMPD S ERR="Invalid CPT code: "_$P(HMP2,U) Q
 ..S HMPP=$$UP^XLFSTR($P(HMP2,U,4))
 ..S HMPP=$O(^VA(200,"B",HMPP,""))
 ..I HMPP'=+HMPP S ERR="Invalid provider name: "_$P(HMP2,U,4) Q
 ..S HMPC=$P(HMP2,U,2),L=0
 ..F I=1:1:$L(HMPC,";") S J=$P(HMPC,";",I) I J]"" D  Q:$G(ERR)]""
 ...S K=$O(^DIC(81.3,"B",J,""))
 ...I K'=+K S ERR="Invalid CPT modifier code: "_J Q
 ...S L=L+1,HMPT=HMPT_";"_J_"/"_K
 ..I $G(ERR)]"" Q
 ..I $G(HMPT)]"" S HMPT=L_HMPT
 ..S HMPE=$P(HMP2,U,5),I=$P($G(^ICPT(HMPD,0)),U,2)
 ..S OUTPUT(CNT)="CPT+^"_HMPN_"^^"_I_U_$P(HMP2,U,3)_U_HMPP_"^^^"_HMPT_U_HMP1_U
 ..S CNT=CNT+1
 ..S OUTPUT(CNT)="COM^"_HMP1_U_$S(HMPE]"":HMPE,1:"@")
 .I TYPE="HF" D
 ..;HMP2=Health factor name^Level/severity code^Comment
 ..S HMPN=$$UP^XLFSTR($P(HMP2,U))
 ..S HMPD=$O(^AUTTHF("B",HMPN,""))
 ..I HMPD'=+HMPD S ERR="Invalid health factor name: "_$P(HMP2,U) Q
 ..S HMPR=$$UP^XLFSTR($P(HMP2,U,2))
 ..I (",H,M,MO,")'[(","_HMPR_",") S ERR="Invalid health factor level code: "_$P(HMP2,U,2) Q
 ..S HMPE=$P(HMP2,U,3)
 ..S OUTPUT(CNT)="HF+^"_HMPD_"^^"_HMPN_U_HMPR_"^^^^^"_HMP1
 ..S CNT=CNT+1
 ..S OUTPUT(CNT)="COM^"_HMP1_U_$S(HMPE]"":HMPE,1:"@")
 .I TYPE="PED" D
 ..;HMP2=Education name^Level of understanding code^Comment
 ..S HMPN=$$UP^XLFSTR($P(HMP2,U))
 ..S HMPD=$O(^AUTTEDT("B",HMPN,""))
 ..I HMPD'=+HMPD S ERR="Invalid education name: "_$P(HMP2,U) Q
 ..S HMPR=$P(HMP2,U,2)
 ..I (",1,2,3,4,5,")'[(","_HMPR_",") S ERR="Invalid education level code: "_$P(HMP2,U,2) Q
 ..S HMPE=$P(HMP2,U,3)
 ..S OUTPUT(CNT)="PED+^"_HMPD_"^^"_HMPN_U_HMPR_"^^^^^"_HMP1
 ..S CNT=CNT+1
 ..S OUTPUT(CNT)="COM^"_HMP1_U_$S(HMPE]"":HMPE,1:"@")
 .I TYPE="POV" D
 ..;HMP2=Diag. code^Search term^EXACT "problem list items" text^Add to problem list^Comment
 ..S HMPF=$S(HMP1=1:1,1:0)  ;Primary diagnosis flag
 ..S HMPE=$P(HMP2,U,5)      ;Comment
 ..S HMPC=$P(HMP2,U)
 ..S HMPD=$O(^ICD9("AB",HMPC_" ",""))
 ..I HMPD'=+HMPD S ERR="Invalid diagnosis code: "_HMPC
 ..I $P(HMP2,U,2)']"",$P(HMP2,U,3)']"" D  Q:$G(ERR)]""
 ...S ERR="For POV, either 'search term' or 'problem list items' needs to be present" Q
 ..S HMPD=$P(HMP2,U,2)
 ..I HMPD]"" D  Q:$G(ERR)]""   ;Search term
 ...K HMPP
 ...;Invoke the existing RPC: ORWLEX GETFREQ; to make sure we are not returning
 ...;too many search results.
 ...D GETFREQ^ORWLEX(.HMPP,HMPD)
 ...I HMPP>5000 S ERR="Your search '"_HMPD_"' matched "_HMPP_" records, that's too many!" Q
 ...I HMPP=0 S ERR="No matches found for your search term: "_HMPD Q
 ...;Invoke the existing RPC: ORWPCE4 LEX; to get more info
 ...D LEX^ORWPCE4(.HMPP,HMPD,"ICD",$$NOW^XLFDT,0,1)
 ...I +$G(HMPP(1))=-1 S ERR="No matches found for your search term: "_HMPD Q
 ...S HMPN=0,HMPR=""
 ...F  S HMPN=$O(HMPP(HMPN)) Q:HMPN'=+HMPN  D  Q:$G(HMPR)]""
 ....I $P(HMPP(HMPN),U,6)=HMPC S HMPR=1 Q  ; Found a matching diagnosis code
 ...I HMPR']"" S ERR="Diagnosis code "_HMPC_" doesn't match the search term: "_HMPD Q
 ...S HMPS=HMPP(HMPN),HMPS=$P(HMPS,U,2)_" ("_$P(HMPS,U,3)_" "_$P(HMPS,U,4)_")"
 ...S HMPT=$S($P(HMP2,U,4)=1:$P(OUTPUT(6),U,2),1:"")  ;Encounter provider IEN
 ...S OUTPUT(CNT)="POV+^"_HMPC_"^^"_HMPS_U_HMPF_U_HMPT_U_+$P(HMP2,U,4)_"^^^"_HMP1
 ...S CNT=CNT+1
 ...S OUTPUT(CNT)="COM^"_HMP1_U_$S(HMPE]"":HMPE,1:"@")
 ..I HMPD']"" S HMPD=$P(HMP2,U,3) D  Q:$G(ERR)]""   ;Problem list item
 ...S OUTPUT(CNT)="POV+^"_HMPC_"^Problem List Items^"_HMPD_U_HMPF_"^^0^^^"_HMP1
 ...S CNT=CNT+1
 ...S OUTPUT(CNT)="COM^"_HMP1_U_$S(HMPE]"":HMPE,1:"@")
 .I TYPE="SK" D  ;Skin Tests
 ..;HMP2=Skin test name^Result code^Reading^Comment
 ..S HMPN=$$UP^XLFSTR($P(HMP2,U))
 ..S HMPD=$O(^AUTTSK("B",HMPN,""))
 ..I HMPD'=+HMPD S ERR="Invalid skin test name: "_$P(HMP2,U) Q
 ..S HMPR=$$UP^XLFSTR($P(HMP2,U,2))
 ..I (",D,N,O,P,")'[(","_HMPR_",") S ERR="Invalid skin test result code: "_$P(HMP2,U,2) Q
 ..S HMPE=$P(HMP2,U,4)
 ..S OUTPUT(CNT)="SK+^"_HMPD_"^^"_HMPN_U_HMPR_"^^"_$P(HMP2,U,3)_"^^^"_HMP1
 ..S CNT=CNT+1
 ..S OUTPUT(CNT)="COM^"_HMP1_U_$S(HMPE]"":HMPE,1:"@")
 .I TYPE="XAM" D  ;Exams
 ..;HMP2=Exam name^Result code^Comment
 ..S HMPN=$$UP^XLFSTR($P(HMP2,U))
 ..S HMPD=$O(^AUTTEXAM("B",HMPN,""))
 ..I HMPD'=+HMPD S ERR="Invalid exam name: "_$P(HMP2,U) Q
 ..S HMPR=$$UP^XLFSTR($P(HMP2,U,2))
 ..I (",A,N,")'[(","_HMPR_",") S ERR="Invalid exam result code: "_$P(HMP2,U,2) Q
 ..S HMPE=$P(HMP2,U,3)
 ..S OUTPUT(CNT)="XAM+^"_HMPD_"^^"_HMPN_U_HMPR_"^^^^^"_HMP1
 ..S CNT=CNT+1
 ..S OUTPUT(CNT)="COM^"_HMP1_U_$S(HMPE]"":HMPE,1:"@")
 Q
