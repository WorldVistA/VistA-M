YTSBBHI2 ;SLC/DJE- ANSWERS SPECIAL HANDLING - BBHI-2 ; 10/16/18 9:35am
 ;;5.01;MENTAL HEALTH;**139**;;Build 134
 ;
DATA1(SCORE) ;expects YSDATA, returns SCORE, multiple scales so we use nodes i.e. SCORE(SCALEIEN)=###
 ;specialized DATA1 uses SCOREDAT table to map question to score relationships
 N LINE,TEXT,SKIP,I
 F LINE=1:1 S TEXT=$P($T(SCOREDAT+LINE),";",2) Q:TEXT="QUIT"  D
 .N SCALE,RAWTYPE,QUESTIONS,I
 .S SCALE=$P(TEXT,"|",1) S RAWTYPE=$P(TEXT,"|",3) S QUESTIONS=$P(TEXT,"|",4)
 .F I=1:1:$L(QUESTIONS,U) D
 ..N NODE,DATA,RAW
 ..S NODE=$P(QUESTIONS,U,I)+2 ;YSDATA question nodes start at 3 and also skip question 0
 ..S DATA=YSDATA(NODE)
 ..;retrieval method section. For each RAWTYPE assign a value to RAW
 ..;typical case, YSDATA piece 3 has the MH CHOICE IEN and raw value is in LEGACY field
 ..I RAWTYPE="LEGACY" S RAW=$$GET1^DIQ(601.75,$P($G(DATA),U,3)_",",4,"I")
 ..;reverse score legacy field - need to make sure skipped value is not reverse scored
 ..I RAWTYPE="YCAGEL" D
 ...S RAW=$$GET1^DIQ(601.75,$P($G(DATA),U,3)_",",4,"I")
 ...I RAW="X" Q
 ...S RAW=3-RAW ;0 to 3 -> 3 to 0
 ..I $G(RAW)="X" S SKIP(SCALE)=$G(SKIP(SCALE))+1 Q
 ..;raw score is stored directly in YSDATA piece 3 - trackbars do this.
 ..I RAWTYPE="DIRECT" S RAW=$P($G(DATA),U,3)
 ..I $G(RAW)="Left blank by the user." S SKIP(SCALE)=$G(SKIP(SCALE))=SKIP(SCALE)+1 Q
 ..S SCORE(SCALE)=$G(SCORE(SCALE))+RAW
 ;
 ;Check scale validity
 I $G(SKIP(1225))=10 S SCORE(1225)=""
 I $G(SKIP(1226))>2 S SCORE(1226)=""
 I $G(SKIP(1227))>2 S SCORE(1227)=""
 I $G(SKIP(1228))>1 S SCORE(1228)=""
 I $G(SKIP(1229))>1 S SCORE(1229)=""
 I $G(SKIP(1230))>2 S SCORE(1230)=""
 Q
 ;
SCOREDAT ; SCALE IEN|SCALE NAME|RAW VALUE STORAGE TYPE|QUES#^QUES#
 ;1225|Pain Complaints|LEGACY|1^2^3^4^5^6^7^8^9^10
 ;1226|Somatic Complaints|LEGACY|15^16^17^18^19^20^21^23^24^25
 ;1227|Defensiveness|LEGACY|43^53^56
 ;1227|Defensiveness|YCAGEL|47^49^58^60^62
 ;1228|Depression|LEGACY|46^52^55^57^59
 ;1228|Depression|YCAGEL|44
 ;1229|Anxiety|LEGACY|45^48^51^54^61^63
 ;1230|Functional|LEGACY|27^29^34^39^42
 ;1230|Functional|YCAGEL|31^32^36^38^41
 ;QUIT
 Q
 ;
SCORESV(SCORE) ;SCORE(SCALE_IEN)=###
 N YSCORNODE,YSGNODE
 I $D(^TMP($J,"YSG",1)),^TMP($J,"YSG",1)="[ERROR]" D  Q  ;-->out
 .K ^TMP($J,"YSCOR")
 .S ^TMP($J,"YSCOR",1)="[ERROR]"
 .S ^TMP($J,"YSCOR",2)="No Scale found for ADMIN"
 ;
 K ^TMP($J,"YSCOR")
 S ^TMP($J,"YSCOR",1)="[DATA]"
 S YSCORNODE=2
 S YSGNODE=2 F  S YSGNODE=$O(^TMP($J,"YSG",YSGNODE)) Q:YSGNODE=""  D
 .N SCALEIEN
 .I $E(^TMP($J,"YSG",YSGNODE),1,5)'="Scale" Q  ;only read the lines for scales
 .S SCALEIEN=+$P(^TMP($J,"YSG",YSGNODE),"=",2) ;grab the first number after "=" sign
 .S ^TMP($J,"YSCOR",YSCORNODE)=$$GET1^DIQ(601.87,SCALEIEN_",",3,"I")_"="_SCORE(SCALEIEN)
 .S YSCORNODE=YSCORNODE+1
 D TSCORING(.YSDATA)
 Q
 ;
DLLSTR(YSDATA,YS,YSTRNG) ;
 N SCORE,TSARR
 ;
 S SCORE=0
 I YSTRNG=1 D DATA1(.SCORE),SCORESV(.SCORE)
 I YSTRNG=2 D LDTSCOR^YTSCORE(.TSARR,YS("AD")),BUILDANS(.TSARR,.YSDATA)
 Q
 ;
BUILDANS(TSARR,YSDATA) ;
 N QUES,I,RANGE,PEAK,PAINTOL,DIAGNOSTIC,YSANSWER,TEXT,VALITEM,DEFRT,VALTEXT,NODE,SCALE,CRITLIST,PAINOMIT,SKIP,MEDIANTEXT,MEDIANLIST
 ;
 S N=N+1
 ;
 ;##VALIDITY SECTION
 ;reuse SCOREDAT table to count skipped questions
 F LINE=1:1 S TEXT=$P($T(SCOREDAT+LINE),";",2) Q:TEXT="QUIT"  D
 .N SCALENAME,QUESTIONS,I
 .S SCALENAME=$P(TEXT,"|",2),QUESTIONS=$P(TEXT,"|",4)
 .F SCALE=1:1:$L(QUESTIONS,U) D
 ..N DATA S DATA=$P($G(YSDATA($P(QUESTIONS,U,SCALE)+2)),U,3)
 ..I DATA=1155 S SKIP(SCALENAME)=$G(SKIP(SCALENAME))+1 Q
 ..I DATA="Left blank by the user." S SKIP(SCALENAME)=$G(SKIP(SCALENAME))+1
 S TEXT="  "
 S VALITEM=+$$GET1^DIQ(601.75,$P($G(YSDATA(52)),U,3)_",",4,"I") ;question 50
 I VALITEM>1 S TEXT="  Random Responding: Results suggest random responding, review critical items section.|"
 S DEFRT=$$RATING("Defensiveness",$P(TSARR("Defensiveness"),U,3)) ;send Defensiveness px t-score for rating
 I (DEFRT["Extremely")!(DEFRT["Very") S TEXT=TEXT_"Biased Responding: Results of Defensiveness Scale suggest biased responding.|"
 S VALTEXT=""
 I $G(SKIP("Pain Complaints")) S VALTEXT="Pain Complaints: check omitted items.|"
 I $P(TSARR("Pain Complaints"),U,2)="" S VALTEXT="All Pain Complaints items omitted.|"
 F SCALE="Somatic Complaints","Defensiveness","Depression","Anxiety","Functional" D
 .I $P(TSARR(SCALE),U,2)="" S VALTEXT=VALTEXT_SCALE_" scale is invalid.|" Q
 .I $G(SKIP(SCALE)) S VALTEXT=VALTEXT_SCALE_": check omitted items.|"
 I $L(VALTEXT) S TEXT=TEXT_VALTEXT
 I TEXT="  " S TEXT="  Valid: No indicators of suspect validity present.|"
 S YSDATA(N)="7771^9999;1^"_TEXT,N=N+1
 ;
 ;##PAIN AREA SECTION
 S QUES(0)=$$GET1^DIQ(601.75,$P($G(YSDATA(66)),U,3)_",",4,"I")
 S MEDIANTEXT=$$EPAD($$GET1^DIQ(601.75,$P($G(YSDATA(66)),U,3)_",",3,"I"),15)
 S YSDATA(N)="7791^9999;1^"_MEDIANTEXT,N=N+1
 I QUES(0)=1 S TEXT="82 patients with headache and head injury pain"
 I QUES(0)=2 S TEXT="99 patients with neck pain/injury"
 I QUES(0)=3 S TEXT="220 patients with upper extremity pain/injury"
 I QUES(0)=4 S TEXT="316 patients with lower back pain/injury"
 I QUES(0)=5 S TEXT="182 patients with lower extremity pain/injury"
 S YSDATA(N)="7792^9999;1^"_TEXT,N=N+1
 S TEXT="  Pain Area                  Pt    "_MEDIANTEXT_" Median for|"
 S TEXT=TEXT_"                                 Median*          Community**|"
 S MEDIANLIST=$P("7273113503^6085115603^4067002302^3041004805^3031003507",U,QUES(0))
 F I=1:1:14 D  ;store pain question data, including question 0
 .N DATA
 .S DATA=$P($G(YSDATA(I+2)),U,3)
 .S QUES(I)=$$GET1^DIQ(601.75,DATA_",",4,"I")
 .I DATA=1155 S QUES(I)="--"
 F I=1:1:10 D  ;generate text 
 .N DATA,QTEXT
 .S QTEXT=$$GET1^DIQ(601.72,$P($G(YSDATA(I+2)),U,1)_",",1,"","QTEXT")
 .S TEXT=TEXT_$$EPAD(QTEXT(1)_":",25)_$$PAD(QUES(I),2)_"       "_$E(MEDIANLIST,I)_"                "_$E(2020000201,I)_"|"
 S YSDATA(N)="7787^9999;1^"_TEXT,N=N+1
 ;
 ;##PAIN DIMENSIONS SECTION
 ;Find peak pain for Q1-10
 S PEAK="--"
 F I=1:1:10 D
 .I QUES(I)="--" Q
 .I (QUES(I)>PEAK)!(PEAK="--") S PEAK=QUES(I)
 D  ;Find pain range
 .I QUES(11)_QUES(12)["--" S RANGE="--" Q
 .S RANGE=QUES(11)-QUES(12)
 ;Peak Pain
 I QUES(11)="--" S PEAK="--"
 I QUES(11)>PEAK S PEAK=QUES(11)
 D  ;Pain Tolerance
 .I (QUES(14)_PEAK)["--" S PAINTOL="--" Q
 .S PAINTOL=QUES(14)-PEAK
 S YSDATA(N)="7788^9999;1^"_$$PAD(QUES(11),2),N=N+1
 S YSDATA(N)="7789^9999;1^"_$$PAD(QUES(12),2)_"       "_$E("33232",QUES(0))_"                0",N=N+1
 S YSDATA(N)="7790^9999;1^"_$$PAD(QUES(14),2),N=N+1
 S YSDATA(N)="7772^9999;1^"_$$PAD(QUES(13),2),N=N+1
 S YSDATA(N)="7773^9999;1^"_$$PAD(RANGE,3),N=N+1
 S YSDATA(N)="7774^9999;1^"_$$PAD(PEAK,2),N=N+1
 S YSDATA(N)="7775^9999;1^"_$$PAD(PAINTOL,3),N=N+1
 ;
 ;##PATIENT SCALE SCORES SECTION
 S NODE=7777
 F SCALE="Defensiveness","Somatic Complaints","Pain Complaints","Functional","Depression","Anxiety" D
 .N PROFILETEXT,TPX,TCOM S PROFILETEXT=""
 .I $P(TSARR(SCALE),U,2)="" D  Q
 ..S YSDATA(N)=NODE_"^9999;1^ "_$$EPAD(SCALE,19)_"--    --    --                :....:....:"
 ..S N=N+1,NODE=NODE+1
 .S TPX=+$P(TSARR(SCALE),U,3),TCOM=+$P(TSARR(SCALE),U,4)
 .S TEXT=$$EPAD(SCALE,19)_$$PAD($P(TSARR(SCALE),U,2),2)_"   "_$$PAD(TPX,3)_"   "_$$PAD(TCOM,3)
 .S TEXT=$$EPAD(TEXT,35) ;profile graph starts at 37 characters
 .;the profile graph crops values <10 and >90, squeezes the 80 point range into 40 characters.
 .S $E(PROFILETEXT,(40-10)/2)=":....:....:"
 .S:TPX<10 TPX=10 S:TCOM<10 TCOM=10 S:TPX>90 TPX=90 S:TCOM>90 TCOM=90 ;crop values outside of graph
 .S $E(PROFILETEXT,(TPX-10)/2)="P",$E(PROFILETEXT,(TCOM-10)/2)="C",PROFILETEXT=PROFILETEXT
 .I TPX>50 D ARROWS(.PROFILETEXT,(50-10)/2,">",(TPX-10)/2,(TCOM-10)/2)
 .I TPX<50 D ARROWS(.PROFILETEXT,(TPX-10)/2,"<",(50-10)/2,(TCOM-10)/2)
 .I TCOM>50 D ARROWS(.PROFILETEXT,(50-10)/2,">",(TCOM-10)/2,(TPX-10)/2)
 .I TCOM<50 D ARROWS(.PROFILETEXT,(TCOM-10)/2,"<",(50-10)/2,(TPX-10)/2)
 .S TEXT=TEXT_PROFILETEXT
 .S YSDATA(N)=NODE_"^9999;1^ "_TEXT,N=N+1,NODE=NODE+1 ;nodes 7777 to 7782
 ;
 ;##RATING SECTION
 S I=0,TEXT=" "
 F SCALE="Defensiveness","Somatic Complaints","Pain Complaints","Functional","Depression","Anxiety" D
 .N PXT S PXT=$P(TSARR(SCALE),U,3),I=I+1
 .I $P(TSARR(SCALE),U,2)="" S TEXT=TEXT_$$EPAD(SCALE_":",21)_$$EPAD("----",16)_"       --%|" Q
 .S TEXT=TEXT_$$EPAD(SCALE_":",21)_$$EPAD($$RATING(SCALE,PXT),16)_"       "_$P(TSARR(SCALE),U,5)_"%|"
 S YSDATA(N)="7783^9999;1^ "_TEXT,N=N+1
 ;
 ;##CRITICAL ITEMS/AREAS SECTION
 S YSDATA(N)="7784^9999;1^"_$$CRITICAL(.YSDATA),N=N+1
 ;
 ;##OMITTED ITEMS SECTION
 S TEXT="  "
 F I=1:1:63 D
 .N DATA,SKIP
 .S DATA=YSDATA(I+2),SKIP=0
 .I ($P($G(DATA),U,3)=1155)!($P($G(DATA),U,3)="Left blank by the user.") D
 ..N QTEXT
 ..S QTEXT=$$GET1^DIQ(601.72,$P($G(YSDATA(I+2)),U,1)_",",1,"","QTEXT")
 ..S TEXT=TEXT_I_". "_QTEXT(1)_"|"
 I TEXT="  " S TEXT="  None|"
 S YSDATA(N)="7785^9999;1^"_TEXT,N=N+1
 ;
 ;##RANDOM RESPONDING CHECK SECTION
 S TEXT="  Negative"
 I VALITEM>1 S TEXT="  50. I am allergic to the glass found in jars.|  "_(VALITEM+1)_". "_$$GET1^DIQ(601.75,$P($G(YSDATA(52)),U,3)_",",3,"I")
 S YSDATA(N)="7786^9999;1^"_TEXT,N=N+1
 Q
EXP(%X) ; e to the X power
 D EXP^XTFN ; takes %X and returns %E
 Q %E
PAD(VAL,LENGTH) ; padds the value with spaces at beginning
 N RETURN,PADDING
 I VAL="Left blank by the user." S VAL="--"
 S PADDING=LENGTH-$L(VAL)
 I PADDING'>0 Q VAL
 S $P(RETURN," ",PADDING+1)=VAL
 Q RETURN
 ;
EPAD(VAL,LENGTH) ; padds the value with spaces at end
 N RETURN,PADDING
 S PADDING=LENGTH-$L(VAL)
 I PADDING'>0 Q VAL
 S $P(VAL," ",PADDING+1+$L(VAL," "))=""
 Q VAL
 ;
TSCORING(YSDATA) ; add T-scores and percentiles
 N IDX,SCORENAME,RAW
 I ^TMP($J,"YSCOR",1)'="[DATA]" Q
 S IDX=1
 F  S IDX=$O(^TMP($J,"YSCOR",IDX)) Q:'IDX  D
 .S SCORENAME=$P(^TMP($J,"YSCOR",IDX),"=",1)
 .S RAW=$P(^TMP($J,"YSCOR",IDX),"=",2)
 .I RAW="" Q  ;Invalid scale
 .S ^TMP($J,"YSCOR",IDX)=^TMP($J,"YSCOR",IDX)_U_$$GETTPER(RAW,SCORENAME)
 ;
GETTPER(RAW,SCORENAME) ; get the T score and percentile given a score's raw #
 N LINE,TEXT,TABLE,X,RETURN
 ;special formatting for raw and scorename
 S SCORENAME=$$UP^XLFSTR(SCORENAME)
 S TABLE=$E(SCORENAME,1,4)_"T"
 S RAW="|"_RAW_U
 ;get t-scores, there are two: patient and community
 F LINE=1:1 S TEXT=$T(@TABLE+LINE) D  Q:TEXT["Q"
 .I TEXT[RAW D  ;if this line contains the raw number
 ..S TEXT=$P(TEXT,RAW,2) ;strip up to raw 
 ..S RETURN=$P(TEXT,"|") ;get t scores
 ..S TEXT="Q"
 ;Patient percentile
 S X="|"_$P(RETURN,U)_U ;use patient T score to retrieve
 S TABLE=$E(SCORENAME,1,4)_"P"
 I TABLE="PAINP" S X=RAW ;pain table uses raw
 F LINE=1:1 S TEXT=$T(@TABLE+LINE) D  Q:TEXT["Q"
 .I TEXT[X D  ;if this line contains the index
 ..S TEXT=$P(TEXT,X,2) ;strip up to index
 ..S RETURN=RETURN_U_$P(TEXT,"|") ;get percentile
 ..S TEXT="Q"
 ;The community percentile is defined in the PDD but we don't use it in this instrument's report
 ;In any case, we only have fields for three extra scores
 Q RETURN
PAINT ; Pain T Scores table |raw^px T score^community T score|
 ;|0^34^39|1^35^40|2^35^40|3^36^41|4^37^42|5^37^42|6^38^43|7^38^44|
 ;|8^39^44|9^39^45|10^40^45|11^40^46|12^41^47|13^42^47|14^42^48|
 ;|15^43^49|16^43^49|17^44^50|18^44^50|19^45^51|20^45^52|21^46^52|
 ;|22^47^53|23^47^54|24^48^54|25^48^55|26^49^56|27^49^56|28^50^57|
 ;|29^50^57|30^51^58|31^52^59|32^52^59|33^53^60|34^53^61|35^54^61|
 ;|36^54^62|37^55^62|38^56^63|39^56^64|40^57^64|41^57^65|42^58^66|
 ;|43^58^66|44^59^67|45^59^68|46^60^68|47^61^69|48^61^69|49^62^70|
 ;|50^62^71|51^63^71|52^63^72|53^64^73|54^64^73|55^65^74|56^66^74|
 ;|57^66^75|58^67^76|59^67^76|60^68^77|61^68^78|62^69^78|63^69^79|
 ;|64^70^80|65^71^80|66^71^81|67^72^81|68^72^82|69^73^83|70^73^83|
 ;|71^74^84|72^74^85|73^75^85|74^76^86|75^76^86|76^77^87|77^77^88|
 ;|78^78^88|79^78^89|80^79^90|81^80^90|82^80^91|83^81^92|84^81^92|
 ;|85^82^93|86^82^93|87^83^94|88^83^95|89^84^95|90^85^96|91^85^97|
 ;|92^86^97|93^86^98|94^87^98|95^87^99|96^88^100|97^88^100|98^89^101|
 ;|99^90^102|100^90^102|
 Q
 ;
SOMAT ; Somatic T Scores table |raw^px T score^community T score|
 ;|0^37^39|1^39^42|2^41^44|3^42^46|4^44^48|5^45^50|6^47^52|7^49^54|
 ;|8^50^56|9^52^59|10^53^61|11^55^63|12^57^65|13^58^67|14^60^69|
 ;|15^62^71|16^63^73|17^65^75|18^66^78|19^68^80|20^70^82|21^71^84|
 ;|22^73^86|23^75^88|24^76^90|25^78^92|26^79^95|27^81^97|28^83^99|
 ;|29^84^101|30^86^103|
 Q
 ;
DEFET ; Defensiveness T Scores table |raw^px T score^community T score|
 ;|0^20^12|1^22^14|2^25^17|3^27^19|4^29^21|5^31^24|6^34^26|7^36^29|
 ;|8^38^31|9^40^33|10^42^36|11^45^38|12^47^40|13^49^43|14^51^45|
 ;|15^54^47|16^56^50|17^58^52|18^60^54|19^63^57|20^65^59|21^67^62|
 ;|22^69^64|23^71^66|24^74^69|
 Q
 ;
DEPRT ; Depression T Scores table |raw^px T score^community T score|
 ;|0^31^35|1^34^38|2^37^41|3^40^44|4^43^47|5^46^51|6^48^54|7^51^57|
 ;|8^54^60|9^57^63|10^60^66|11^63^69|12^66^72|13^69^76|14^72^79|
 ;|15^74^82|16^77^85|17^80^88|18^83^91|
 Q
 ;
ANXIT ; Anxiety T Scores table |raw^px T score|community T score|
 ;|0^26^30|1^30^34|2^33^37|3^37^41|4^40^44|5^43^47|6^47^51|7^50^54|
 ;|8^54^58|9^57^61|10^61^65|11^64^68|12^68^72|13^71^75|14^74^79|
 ;|15^78^82|16^81^86|17^85^89|18^88^92|
 Q
 ;
FUNCT ; Functional T Scores table |raw^px T score^community T score|
 ;|0^25^30|1^27^33|2^29^35|3^30^37|4^32^40|5^34^42|6^36^44|7^38^46|
 ;|8^40^49|9^42^51|10^44^53|11^46^56|12^47^58|13^49^60|14^51^62|
 ;|15^53^65|16^55^67|17^57^69|18^59^72|19^61^74|20^63^76|21^64^78|
 ;|22^66^81|23^68^83|24^70^85|25^72^88|26^74^90|27^76^92|28^78^94|
 ;|29^80^97|30^81^99|
 Q
PAINP ; Pain px percentiles table |raw^px percentile|
 ;|0^1|1^2|2^3|3^4|4^5|5^6|6^7|7^9|8^11|9^13|10^15|11^17|12^19|
 ;|13^22|14^24|15^28|16^30|17^31|18^34|19^36|20^38|21^40|22^43|
 ;|23^45|24^48|25^51|26^53|27^55|28^57|29^59|30^60|31^62|32^63|
 ;|33^65|34^67|35^69|36^71|37^72|38^73|39^75|40^76|41^77|42^78|
 ;|43^79|44^80|45^81|46^82|47^84|48^85|49^86|50^88|51^89|52^90|
 ;|53^90|54^91|55^91|56^92|57^93|58^94|59^95|60^95|61^95|62^95|
 ;|63^96|64^96|65^96|66^97|67^97|68^97|69^98|70^98|71^98|72^99|
 ;|73^99|74^99|75^99|76^99|77^99|78^99|79^99|80^99|81^99|82^99|
 ;|83^99|84^99|85^99|86^99|87^99|88^99|89^99|90^99|91^99|92^99|
 ;|93^99|94^99|95^99|96^99|97^99|98^99|99^99|100^99|
 Q
SOMAP ; Somatic px percentiles table |px T score^px percentile|
 ;|37^4|39^12|41^19|42^25|44^32|45^40|47^46|49^53|50^58|52^62|53^67|
 ;|55^73|57^78|58^82|60^85|62^87|63^88|65^90|66^91|68^92|70^93|71^95|
 ;|73^97|75^99|76^99|78^99|79^99|81^99|83^99|84^99|86^99|
 Q
DEFEP ; Defensiveness px percentiles table |px T score^px percentile|
 ;|20^1|22^1|25^1|27^2|29^2|31^4|34^6|36^8|38^11|40^17|42^24|45^31|
 ;|47^37|49^44|51^53|54^63|56^73|58^81|60^86|63^91|65^94|67^95|69^97|
 ;|71^98|74^99|
 Q
DEPRP ; Depression px percentiles table |px T score^px percentile|
 ;|31^1|34^5|37^8|40^14|43^23|46^35|48^48|51^61|54^71|57^78|60^83|
 ;|63^88|66^92|69^95|72^97|74^98|77^99|80^99|83^99|
 Q
ANXIP ; Anxiety px percentiles table |px T score^px percentile|
 ;|26^1|30^3|33^6|37^11|40^17|43^24|47^36|50^50|54^65|57^78|61^86|
 ;|64^92|68^96|71^98|74^99|78^99|81^99|85^99|88^99|
 Q
FUNCP ; Functional px percentiles table |px T score^px percentile|
 ;|25^1|27^1|29^1|30^1|32^2|34^5|36^9|38^12|40^16|42^20|44^27|46^35|
 ;|47^43|49^50|51^58|53^65|55^71|57^76|59^81|61^85|63^89|64^92|66^94|
 ;|68^95|70^97|72^98|74^98|76^99|78^99|80^99|81^99|
 Q
 ;
RATING(SCALE,PXT) ;Get scale rating given px t-score
 N TSCORERANGES,I,RANGE,RATING
 F I=1:1:6 D
 .I $P($T(RATEDATA+I),"|",1)'[SCALE Q
 .S TSCORERANGES=$P($T(RATEDATA+I),"|",2)
 Q:$G(TSCORERANGES)="" -1
 S I=0 F  S I=I+1,RANGE=$P(TSCORERANGES,U,I) Q:RANGE=""  Q:(PXT'<+RANGE)&(PXT'>+$P(RANGE,"-",2))
 Q $P(RANGE,"=",2)
 ;
RATEDATA ;
 ;Pain Complaints|34-34=Extremely Low^35-37=Very Low^38-40=Low^41-52=Average^53-59=Moderately High^60-66=High^67-72=Very High^73-90=Extremely High
 ;Somatic Complaints|37-37=Very Low^39-39=Low^41-52=Average^53-58=Moderately High^60-70=High^71-73=Very High^75-86=Extremely High
 ;Defensiveness|20-25=Extremely Low^27-31=Very Low^34-40=Low^42-47=Moderately Low^49-58=Average^60-65=High^67-69=Very High^71-74=Extremely High
 ;Depression|31-31=Extremely Low^34-34=Very Low^37-40=Low^43-51=Average^54-57=Moderately High^60-66=High^69-72=Very High^74-83=Extremely High
 ;Anxiety|26-26=Extremely Low^30-33=Very Low^37-40=Low^43-54=Average^57-57=Moderately High^61-64=High^68-68=Very High^71-88=Extremely High
 ;Functional|25-30=Extremely Low^32-34=Very Low^36-40=Low^42-47=Average^49-59=Moderately High^61-64=High^66-68=Very High^70-81=Extremely High
 ;
CRITICAL(YSDATA) ;
 N TEXT
 S TEXT="  "
 F I=1:1:16 D
 .N DATA,QUESTION,AREA,QTEXT,ANSTEXT,VALUE
 .S DATA=$T(CRITDATA+I)
 .S QUESTION=$P(DATA,U,2)
 .S VALUE=+$$GET1^DIQ(601.75,$P($G(YSDATA(QUESTION+2)),U,3)_",",4,"I")
 .I "31,33,26"[QUESTION S VALUE=3-VALUE ;these three questions have reverse scoring 0->3,3->0
 .I VALUE<2 Q  ;question scored as 0 or 1, exit.
 .S AREA=$P(DATA,U,3)_"|"
 .I TEXT'[AREA S TEXT=TEXT_AREA ;Skip if we already have printed the area
 .S QTEXT=$$GET1^DIQ(601.72,$P($G(YSDATA(QUESTION+2)),U,1)_",",1,"","QTEXT")
 .S ANSTEXT=$$GET1^DIQ(601.75,$P($G(YSDATA(QUESTION+2)),U,3)_",",3,"I")
 .;use only first one or two words
 .S ANSTEXT=$P(ANSTEXT," ",1,2)
 .I ($P(ANSTEXT," ",1)="Disagree")!($P(ANSTEXT," ",1)="Agree") S ANSTEXT=$P(ANSTEXT," ",1)
 .S TEXT=TEXT_"  "_QUESTION_". "_QTEXT(1)_" ("_ANSTEXT_")|"
 I TEXT="  " S TEXT="  The patient did not endorse any of the 17 critical items"
 Q TEXT
 ;
CRITDATA ;
 ;^35^Compensation Focus
 ;^31^Sleep Disorder
 ;^51^Death Anxiety
 ;^52^Suicidal Ideation
 ;^28^Chemical Dependency
 ;^33^Chemical Dependency
 ;^37^Doctor Dissatisfaction
 ;^22^Psychosis
 ;^26^Satisfaction with Care
 ;^34^Perceived Disability
 ;^40^Pain Fixation
 ;^30^Home Life Problems
 ;^15^Vegative Depression
 ;^24^Vegative Depression
 ;^21^Anxiety/Panic
 ;^19^PTSD/Dissociation
 ;
ARROWS(LINETEXT,START,FILL,END,NOWRITE) ;fill linetext from start position to end position
 N I
 S START=$P(START,"."),END=$P(END,"."),NOWRITE=$P(NOWRITE,".") ;strip decimals
 F I=(START+1):1:(END-1) D
 .I I=NOWRITE Q
 .S $E(LINETEXT,I)=FILL
 Q
