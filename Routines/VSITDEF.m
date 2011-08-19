VSITDEF ;ISL/dee - Defaulting Logic for the Visit ;4/17/97
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**76,111,130,164,168**;Aug 12, 1996;Build 14
 ; Patch PX*1*76 changes the 2nd line of all VSIT* routines to reflect
 ; the incorporation of the module into PCE.  For historical reference,
 ; the old (VISIT TRACKING) 2nd line is included below to reference VSIT
 ; patches.
 ;
 ;;2.0;VISIT TRACKING;**1,2**;Aug 12, 1996
 ;
 Q  ; - not an entry point
 ;
REQUIRED() ;Check the required variables
 ;and Default all fields that are need for lookup matching
 ; Returns: 0 if no errors and 
 ;          1 if there are errors that prevent processing
 ;          (stored in QUIT)
 N QUIT,SITE
 S QUIT=0
 S SITE=+$$SITE^VASITE($P($G(VSIT("VDT")),"^"))
 ; - VDT
 S VSIT("VDT")=$$ERRCHK^VSITCK("VDT",VSIT("VDT"),$S(VSIT("SVC")="E":"TS",1:""))
 I $L(VSIT("VDT"),"^")>1 D ERR^VSITPUT($P(VSIT("VDT"),"^",2,99)) S QUIT=1
 ; - PAT
 S VSIT("PAT")=$$ERRCHK^VSITCK("PAT",VSIT("PAT"))
 I $L(VSIT("PAT"),"^")>1 D ERR^VSITPUT($P(VSIT("PAT"),"^",2,99)) S QUIT=1
 I VSIT("INS")="",VSIT("OUT")="",VSIT("SVC")'="E" D
 . S VSIT("INS")=$$INS4LOC^VSITCK1(+VSIT("LOC"))
 . I VSIT("INS")']"",SITE>0 S VSIT("INS")=SITE
 . S VSIT("INS")=$$ERRCHK^VSITCK("INS",VSIT("INS"))
 I $L(VSIT("INS"),"^")>1 D ERR^VSITPUT($P(VSIT("INS"),"^",2,99)) S QUIT=1
 ; - LOC
 I (VSIT("INS")=SITE&(VSIT("SVC")'="E"))!(VSIT("LOC")]"") D
 . S VSIT("LOC")=$$ERRCHK^VSITCK("LOC",VSIT("LOC"))
 I $L(VSIT("LOC"),"^")>1 D ERR^VSITPUT($P(VSIT("LOC"),"^",2,99)) S QUIT=1
 ; - TYP
 I VSIT("TYP")']"",VSIT("INS")]"" S VSIT("TYP")="V"
 I VSIT("TYP")']"",VSIT("SVC")="E" S VSIT("TYP")="O"
 S:VSIT("TYP")']"" VSIT("TYP")=$G(DUZ("AG"))
 S:VSIT("TYP")']"" VSIT("TYP")=$P($G(^DIC(150.9,1,0)),"^",3)
 S VSIT("TYP")=$$ERRCHK^VSITCK("TYP",VSIT("TYP"))
 I $L(VSIT("TYP"),"^")>1 D ERR^VSITPUT($P(VSIT("TYP"),"^",2,99)) S QUIT=1
 ; - DSS
 I VSIT("DSS")="",VSIT("LOC")]"" D
 . S VSIT("DSS")=$$DSS4LOC^VSITCK1(+VSIT("LOC"))
 I VSIT("DSS")]"" D
 . S VSIT("DSS")=$$ERRCHK^VSITCK("DSS",VSIT("DSS"))
 I $L(VSIT("DSS"),"^")>1 D ERR^VSITPUT($P(VSIT("DSS"),"^",2,99)) S QUIT=1
 ; - IO
 S VSIT("IO")=$S(VSITIPM>0:1,1:0)
 ; - SVC
 I VSIT("SVC")'="E" D
 . I +VSIT("DSS") D
 .. ;Default svc based on the dss id
 .. I $P(^DIC(40.7,+VSIT("DSS"),0),"^",1)["TELE" S VSIT("SVC")="T" ;any TELEphone
 .. E  I $O(^VSIT(150.1,"B",+$P(^DIC(40.7,+VSIT("DSS"),0),"^",2),0)) S VSIT("SVC")="X"
 .. E  I VSIT("SVC")="",VSIT("DSS")=$P($G(^SC(+VSIT("LOC"),0)),"^",7) S VSIT("SVC")="A"
 . I VSIT("SVC")="" S VSIT("SVC")="X"
 I VSIT("IO") D
 . I VSIT("SVC")="A" S VSIT("SVC")="I"
 . E  I VSIT("SVC")="X" S VSIT("SVC")="D"
 E  D
 . I VSIT("SVC")="I" S VSIT("SVC")="A"
 . E  I VSIT("SVC")="D" S VSIT("SVC")="X"
 S VSIT("SVC")=$$ERRCHK^VSITCK("SVC",VSIT("SVC"))
 I $L(VSIT("SVC"),"^")>1 D ERR^VSITPUT($P(VSIT("SVC"),"^",2,99)) S QUIT=1
 ;
 Q QUIT
 ;
DEFAULTS ;Default all of the rest of the fields that are NOT need for lookup matching
 ; - CDT & MDT
 D
 . N %,%H,%I,X
 . D NOW^%DTC
 . S (VSIT("CDT"),VSIT("MDT"))=%
 ; - LNK
 ;   check if good
 D:VSIT("LNK")]""
 . S VSIT("LNK")=$$GET^VSITVAR("LNK",VSIT("LNK"))
 . I +VSIT("LNK"),+VSIT("PAT") D
 . . S NOD=$G(^AUPNVSIT(+VSIT("LNK"),0))
 . . S:+$P(NOD,"^",11) VSIT("LNK")="" ; delete flag
 . . S:+VSIT("PAT")'=$P(NOD,"^",5) VSIT("LNK")="" ; different patients
 S VSIT("LNK")=$$ERRCHK^VSITCK("LNK",VSIT("LNK"))
 D:$L(VSIT("LNK"),"^")>1 WRN^VSITPUT($P(VSIT("LNK"),"^",2,99))
 ; - COD
 S VSIT("COD")=$$ERRCHK^VSITCK("COD",VSIT("COD"))
 D:$L(VSIT("COD"),"^")>1 WRN^VSITPUT($P(VSIT("COD"),"^",2,99))
 ; - ELG
 I +VSIT("PAT"),$F(VSIT(0),"I")!($F(VSIT(0),"E")) D
 . S:VSIT(0)["I" VSIT("ELG")=$$ELG^VSITASK(VSIT("PAT"))
 . D:VSIT("ELG")=""
 . . S:VSIT("LNK")>0 VSIT("ELG")=$P($G(^AUPNVSIT(VSIT("LNK"),0)),"^",21) ;Eligibility Code form Parent Visit
 . . S:VSIT("ELG")="" VSIT("ELG")=$P($G(^DPT(+VSIT("PAT"),.36)),"^") ;Primary Eligibility Code
 . . D:VSIT("ELG")=""
 . . . N VSITI,VSITE
 . . . S (VSITI,VSITE)=0
 . . . ;See if any eligibilities it the Patient Eigibilities sub-file
 . . . F  S VSITE=$O(^DPT(+VSIT("PAT"),"E",VSITE)) Q:VSITE'>0  S VSITI=VSITI+1
 . . . I VSITI=1 S VSIT("ELG")=$O(^DPT(+VSIT("PAT"),"E",0)) ;If only one use it
 S VSIT("ELG")=$$ERRCHK^VSITCK("ELG",VSIT("ELG"))
 D:$L(VSIT("ELG"),"^")>1 WRN^VSITPUT($P(VSIT("ELG"),"^",2,99))
 ; - USR
 I VSIT("USR")="",+$G(DUZ) S VSIT("USR")=+DUZ
 S VSIT("USR")=$$ERRCHK^VSITCK("USR",VSIT("USR"))
 D:$L(VSIT("USR"),"^")>1 WRN^VSITPUT($P(VSIT("USR"),"^",2,99))
 ; - OPT
 S:VSIT("OPT")="" VSIT("OPT")=$P($G(XQY),"^")
 S VSIT("OPT")=$$ERRCHK^VSITCK("OPT",VSIT("OPT"))
 D:$L(VSIT("OPT"),"^")>1 WRN^VSITPUT($P(VSIT("OPT"),"^",2,99))
 ; - PRO
 I VSIT("PRO")="",$P($G(XQORNOD),";",2)="ORD(101," S VSIT("PRO")=$P($G(XQORNOD),";")
 S VSIT("PRO")=$$ERRCHK^VSITCK("PRO",VSIT("PRO"))
 D:$L(VSIT("PRO"),"^")>1 WRN^VSITPUT($P(VSIT("PRO"),"^",2,99))
 ; - OUT
 S VSIT("OUT")=$$ERRCHK^VSITCK("OUT",VSIT("OUT"))
 D:$L(VSIT("OUT"),"^")>1 WRN^VSITPUT($P(VSIT("OUT"),"^",2,99))
 ; - VID
 S VSIT("VID")=$$GETVID^VSITVID
 ; - PRI
 I VSIT("PRI")="P",$O(^VSIT(150.1,"B",+$P($G(^DIC(40.7,+VSIT("DSS"),0)),"^",2),0)) S VSIT("PRI")="O"
 S VSIT("PRI")=$$ERRCHK^VSITCK("PRI",VSIT("PRI"))
 D:$L(VSIT("PRI"),"^")>1 WRN^VSITPUT($P(VSIT("PRI"),"^",2,99))
 ; - SC
 S VSIT("SC")=$$ERRCHK^VSITCK("SC",VSIT("SC"))
 D:$L(VSIT("SC"),"^")>1 WRN^VSITPUT($P(VSIT("SC"),"^",2,99))
 ; - AO
 S VSIT("AO")=$$ERRCHK^VSITCK("AO",VSIT("AO"))
 D:$L(VSIT("AO"),"^")>1 WRN^VSITPUT($P(VSIT("AO"),"^",2,99))
 ; - IR
 S VSIT("IR")=$$ERRCHK^VSITCK("IR",VSIT("IR"))
 D:$L(VSIT("IR"),"^")>1 WRN^VSITPUT($P(VSIT("IR"),"^",2,99))
 ; - EC
 S VSIT("EC")=$$ERRCHK^VSITCK("EC",VSIT("EC"))
 D:$L(VSIT("EC"),"^")>1 WRN^VSITPUT($P(VSIT("EC"),"^",2,99))
 ; - HNC - PX*1*111 - Head & Neck
 S VSIT("HNC")=$$ERRCHK^VSITCK("HNC",VSIT("HNC"))
 D:$L(VSIT("HNC"),"^")>1 WRN^VSITPUT($P(VSIT("HNC"),"^",2,99))
 ; - CV - PX*1*130 - Combat Vet
 S VSIT("CV")=$$ERRCHK^VSITCK("CV",VSIT("CV"))
 D:$L(VSIT("CV"),"^")>1 WRN^VSITPUT($P(VSIT("CV"),"^",2,99))
 ; - SHAD - PX*1*168 - Project 112/SHAD
 S VSIT("SHAD")=$$ERRCHK^VSITCK("SHAD",VSIT("SHAD"))
 D:$L(VSIT("SHAD"),"^")>1 WRN^VSITPUT($P(VSIT("SHAD"),"^",2,99))
 ; - COM
 S VSIT("COM")=$$ERRCHK^VSITCK("COM",VSIT("COM"))
 D:$L(VSIT("COM"),"^")>1 WRN^VSITPUT($P(VSIT("COM"),"^",2,99))
 ; - VER
 S VSIT("VER")=$$ERRCHK^VSITCK("VER",VSIT("VER"))
 D:$L(VSIT("VER"),"^")>1 WRN^VSITPUT($P(VSIT("VER"),"^",2,99))
 ; - PKG
 S VSIT("PKG")=$$PKG2IEN^VSIT(VSIT("PKG"))
 S VSIT("PKG")=$$ERRCHK^VSITCK("PKG",VSIT("PKG"))
 D:$L(VSIT("PKG"),"^")>1 WRN^VSITPUT($P(VSIT("PKG"),"^",2,99))
 ; - SOR
 ;Lookup source in PCE DATA SOURCE file (#839.7) with LAYGO
 I VSIT("SOR")'=+VSIT("SOR") D
 . I $T(SOURCE^PXAPI)="" D
 .. S VSIT("SOR")=$$SOURCE^PXAPI(VSIT("SOR"))
 . E  S VSIT("SOR")=""
 S VSIT("SOR")=$$ERRCHK^VSITCK("SOR",VSIT("SOR"))
 D:$L(VSIT("SOR"),"^")>1 WRN^VSITPUT($P(VSIT("SOR"),"^",2,99))
 ;
 ;PFSS Patient Reference
 S VSIT("ACT")=$$ERRCHK^VSITCK("ACT",VSIT("ACT"))
 I $$SWSTAT^IBBAPI() D:$L(VSIT("ACT"),"^")>1 WRN^VSITPUT($P(VSIT("ACT"),"^",2,99))
 Q
 ;
