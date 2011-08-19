LRMITSRS ;SLC/STAFF - MICRO TREND REPORT SETUP ;11/7/93  12:33
 ;;5.2;LAB SERVICE;**96**;Sep 27, 1994
 ; from LRMITSR
 ; sets up static information on reports
 ;
 K LRHDR S LRHDR1=$P($$HTE^XLFDT($H),":",1,2)_"  ANTIBIOTIC TREND REPORT  (from "_LRFBEG_" to: "_LRFEND_"   "
 S LRSPACE=$$REPEAT^XLFSTR(" ",5)
 I $D(LROTYPE("B")) D
 .S LRHDR(2)=LRSPACE,LRABRV="",LRAPRT=0
 .I '$D(^TMP($J,"PSRT")) F  S LRABRV=$O(^TMP($J,"AB",LRABRV)) Q:LRABRV=""  S LRHDR(2)=LRHDR(2)_"|"_$E(LRABRV,1,3)
 .I $D(^TMP($J,"PSRT")) F  S LRAPRT=$O(^TMP($J,"PSRT",LRAPRT)) Q:+LRAPRT'>0  S LRABRV=$G(^TMP($J,"PSRT",LRAPRT)),LRHDR(2)=LRHDR(2)_"|"_$E(LRABRV,1,3)
 .S LRHDR(2)=LRHDR(2)_"|"
 I LRLOS S LRHDR(3)=" ** Reports only those specimens collected > "_LRLOS_$S(LRLOS>1:" days",1:" day")_" from admission date **"
 S LRHDR(4)=(IOM-5)\4 S LRHDR(4)="     "_$$REPEAT^XLFSTR("|---",(LRHDR(4)))
 I $D(LRAP) D
 . S LRHDR(5)="* ANTIBIOTIC PATTERN *",LRHDR(6)=LRSPACE
 . S LRABRV="" F  S LRABRV=$O(^TMP($J,"AB",LRABRV)) Q:LRABRV=""  S LRDN=+^(LRABRV) D
 ..S LRHDR(6)=LRHDR(6)_"|"_$J($G(LRAP(LRDN)),3)
 .S LRHDR(6)=LRHDR(6)_"|"
 ; header information
 K LRLINE S LRLINE1="ANTIBIOTIC TREND REPORT BY "
 S LRCNT=2,LRX=LRFBEG_" - "_LRFEND,LRLINE(LRCNT)=$J(LRX,IOM+$L(LRX)\2)
 S LRCNT=LRCNT+1,LRLINE(LRCNT)="",LRCNT=LRCNT+1,LRLINE(LRCNT)="Data reported on: "
 S LRN="" F  S LRN=$O(LROTYPE(LRN)) Q:LRN=""  D
 .S LRLINE(LRCNT)=LRLINE(LRCNT)_$S(LRN="B":"Bacteria",LRN="F":"Fungus",LRN="M":"Mycobacteria",LRN="P":"Parasite",1:"Virus")_$S($L($O(LROTYPE(LRN))):", ",1:"")
 I $D(LRSORG) D
 .S LRCNT=LRCNT+1,LRLINE(LRCNT)="** Only the following organisms are reported:"
 .K LRTEMP S LRNM="" F  S LRNM=$O(LRSORG(LRNM)) Q:LRNM=""  D
 ..S LRN=0 F  S LRN=$O(LRSORG(LRNM,LRN)) Q:LRN<1  S LRX=$P(^LAB(61.2,LRN,0),U),LRX=$E(LRX)_$$LOW^XLFSTR($E(LRX,2,99)),LRTEMP(LRNM_LRN)=LRX
 .D HLIST("LRTEMP","LRLINE",", ",IOM,.LRCNT) K LRTEMP
 I LRLOS S LRCNT=LRCNT+1,LRLINE(LRCNT)="** Data are restricted to specimens collected within "_LRLOS_" days of admission."
 I $D(LRAP) S LRCNT=LRCNT+1,LRLINE(LRCNT)="** Data are restricted to a specific antibiotic pattern."
 I LRDETAIL S LRCNT=LRCNT+1,LRLINE(LRCNT)="** This report includes detailed information on all isolates."
 I LRMERGE="N" S LRCNT=LRCNT+1,LRLINE(LRCNT)="Isolates are NOT merged."
 I LRMERGE'="N" D
 .S LRCNT=LRCNT+1,LRLINE(LRCNT)="Isolates are merged when same patient, same organism, and "_$S(LRMERGE="S":"same specimen",LRMERGE="C":"same collection sample",1:"any sample")_" exists."
 .S LRCNT=LRCNT+1,LRLINE(LRCNT)="Merged isolates are those not having conflicting antibiotic patterns."
 I $D(LROTYPE("B")) D
 .S LRCNT=LRCNT+1,LRLINE(LRCNT)=""
 .S LRCNT=LRCNT+1,LRLINE(LRCNT)="Antibiotics:"
 .K LRTEMP S LRABRV="" F  S LRABRV=$O(^TMP($J,"AB",LRABRV)) Q:LRABRV=""  S LRTEMP(LRABRV)=LRABRV_"="_$P(^(LRABRV),U,2)
 .D HLIST("LRTEMP","LRLINE",", ",IOM,.LRCNT) K LRTEMP
 S LRCNT=LRCNT+1,LRLINE(LRCNT)=""
 Q
HLIST(IN,OUT,DEL,LEN,CNT) ; transforms array IN to horizontal list array OUT, delimited by DEL for maximum length of LEN
 ; CNT is the starting subscript for the OUT array, CNT can be called by reference
 N NEXT,SUB,VALUE S:'$D(LEN) LEN=$S($D(IOM):IOM,1:80) S:'$D(CNT) CNT=0
 S CNT=CNT+1,(@OUT@(CNT),SUB)="" F  S SUB=$O(@IN@(SUB)) Q:SUB=""  S VALUE=$P(@IN@(SUB),U),NEXT=$P($O(@IN@(SUB)),U) D
 .I $L(@OUT@(CNT))+$L(VALUE)>(LEN-$L(DEL)) S CNT=CNT+1,@OUT@(CNT)=""
 .S @OUT@(CNT)=@OUT@(CNT)_VALUE_$S($L(NEXT):DEL,1:"")
 Q
