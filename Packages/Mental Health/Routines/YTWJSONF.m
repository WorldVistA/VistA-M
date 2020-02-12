YTWJSONF ;SLC/KCM - File/Export JSON versions of instruments ; 7/20/2018
 ;;5.01;MENTAL HEALTH;**130**;Dec 30, 1994;Build 62
 ;
 ; External Reference    ICR#
 ; ------------------   -----
 ; %ZISH                 2320
 ; XPDUTL               10141
 ;
SAVEDIR ; Save all active instruments to directory
 ; may need to first remove current files from the destination directory
 ; (this doesn't clean up the destination directory first)
 N PATH
 S PATH=$$PROMPT^YTWJSONU("Destination Directory") Q:'$L(PATH)
 D LPACTV(PATH)
 D LIST(PATH)
 Q
SAVE96 ; Save all active instruments as JSON in 601.96
 D DEL96      ; remove the current entries for active instruments
 D LPACTV("") ; empty path causes save to 601.96
 D LIST96
 Q
 ;
LPACTV(PATH) ; Loop thru all active instruments to create JSON documents
 ; PATH: if empty, JSON documents are saved to 601.96
 ;       otherwise, this specifics the host directory
 N TEST
 S TEST=0 F  S TEST=$O(^YTT(601.71,TEST)) Q:'TEST  D
 . I $P($G(^YTT(601.71,TEST,2)),U,2)'="Y" QUIT
 . I '$L($G(PATH)) D FILE96(TEST) W "."
 . I $L($G(PATH)) D FILE(TEST,PATH) W "."
 Q
 ;
 ; -- calls to write to 601.96
 ;
DEL96 ; Delete active instruments from 601.96
 N NM,IEN
 S NM="YTT " F  S NM=$O(^YTT(601.96,"B",NM)) Q:$E(NM,1,4)'="YTT "  D
 . S IEN=$O(^YTT(601.96,"B",NM,0))
 . D FMDEL^YTXCHGU(601.96,IEN)
 S IEN=$O(^YTT(601.96,"B","YTL ACTIVE",0))
 D FMDEL^YTXCHGU(601.96,IEN)
 Q
FILE96(TEST) ; save JSON test to 601.96
 I TEST'=+TEST S TEST=$O(^YTT(601.71,"B",TEST,0)) Q:'TEST
 Q:'$D(^YTT(601.71,TEST,0))
 ;
 N REC,JSON,IEN
 S REC(.01)="YTT "_$P(^YTT(601.71,TEST,0),U)
 S REC(.02)=1
 S REC(1)="JSON"
 S IEN=$O(^YTT(601.96,"B",REC(.01),0))
 D GETSPEC^YTWJSON(.JSON,TEST)
 I '$D(JSON) D  QUIT 
 . D MES^XPDUTL("Error creating JSON for "_$P(^YTT(601.71,TEST,0),U))
 ;
 I IEN D FMUPD^YTXCHGU(601.96,.REC,IEN) I 1
 E  D FMADD^YTXCHGU(601.96,.REC)
 Q
LIST96 ; Save list of instruments as JSON in 601.96
 N REC,JSON,IEN
 S REC(.01)="YTL ACTIVE"
 S REC(.02)=1
 S REC(1)="JSON"
 S IEN=$O(^YTT(601.96,"B","YTL ACTIVE",0))
 D NAMES^YTWJSONU(.JSON)
 I IEN D FMUPD^YTXCHGU(601.96,.REC,IEN) I 1
 E  D FMADD^YTXCHGU(601.96,.REC)
 Q
 ;
 ; -- calls to write to host directory
 ;
FILE(TEST,PATH) ; save JSON test to a file
 I TEST'=+TEST S TEST=$O(^YTT(601.71,"B",TEST,0)) Q:'TEST
 ;
 N JSON,OK
 D GETSPEC^YTWJSON(.JSON,TEST)
 I '$D(JSON) W !,"Error creating JSON for "_$P(^YTT(601.71,TEST,0),U) QUIT
 ;
 K ^TMP($J)
 M ^TMP($J)=JSON ; so can use $$GTF^%ZISH
 N NAME S NAME=$TR($P(^YTT(601.71,TEST,0),U)," ","_")_".json"
 S OK=$$GTF^%ZISH($NA(^TMP($J,1)),2,PATH,NAME)
 I 'OK W !,"Error writing file: "_NAME
 K ^TMP($J)
 Q
LIST(PATH) ; Save list of instruments as JSON to directory
 N JSON,OK
 D NAMES^YTWJSONU(.JSON)
 K ^TMP($J) M ^TMP($J)=JSON
 S OK=$$GTF^%ZISH($NA(^TMP($J,1)),2,PATH,"instrumentList.json")
 I 'OK W !,"Error writing file: instrumentList.json"
 K ^TMP($J)
 Q
 ;
