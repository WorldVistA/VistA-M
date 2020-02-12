YS130PS0 ;SLC/KCM - Patch 130 Post-Init Update Categories ; 1/25/2017
 ;;5.01;MENTAL HEALTH;**130**;Dec 30, 1994;Build 62
 ;
 ; External Reference    ICR#
 ; ------------------   -----
 ; %ZOSV                10097
 ; DIE                   2053
 ; DIK                  10013
 ; DILF                  2054
 ; XPDUTL               10141
 ;
 Q
SHOCATS ; List out categories for inclusion in routine 
 N TEST,X,CAT,IEN,LIST
 S TEST=0 F  S TEST=$O(^YTT(601.71,TEST)) Q:'TEST  D
 . I $P($G(^YTT(601.71,TEST,2)),U,2)'="Y" QUIT  ; active instrument?
 . S X="",CAT=0 F  S CAT=$O(^YTT(601.71,TEST,10,CAT)) Q:'CAT  D
 . . S IEN=+^YTT(601.71,TEST,10,CAT,0)
 . . S X=X_$S($L(X):U,1:"")_$P(^YTT(601.97,IEN,0),U)
 . I $L(X) S LIST($P(^YTT(601.71,TEST,0),U))=X
 S X="" F  S X=$O(LIST(X)) Q:'$L(X)  W !," ;;"_X_U_LIST(X)
 Q
SETCATS ; Set categories from CATLST into 601.71
 ; Don't run this install in the dev environment
 N Y D GETENV^%ZOSV I $P(Y,U,4)="SPPNXT:VISTA" Q
 ;
 N YSI,YSJ,YSX,YSNM,YSIEN,YSCATS,YSCAT,YSCNT
 S YSCNT=0
 F YSI=1:1 S YSX=$P($T(CATLST+YSI),";;",2,99) Q:YSX="zzzzz"  D
 . S YSNM=$P(YSX,U,1),YSCATS=$P(YSX,U,2,99)
 . S YSIEN=$O(^YTT(601.71,"B",YSNM,0)) Q:'YSIEN
 . D DELCATS(YSIEN)
 . N FDA,FDAIEN,DIERR
 . F YSJ=1:1:$L(YSCATS,U) D
 . . S YSCAT=$P(YSCATS,U,YSJ) Q:'$L(YSCAT)
 . . S YSCNT=YSCNT+1
 . . S FDA(601.71101,"+"_YSJ_","_YSIEN_",",.01)=YSCAT
 . Q:$D(FDA)<10
 . D UPDATE^DIE("E","FDA","FDAIEN")
 . I $D(DIERR) D MES^XPDUTL(YSNM_": "_$G(^TMP("DIERR",$J,1,"TEXT",1)))
 . D CLEAN^DILF
 D MES^XPDUTL("Instrument categories updated: "_YSCNT)
 Q
DELCATS(YSIEN) ; Delete the categories for instrument YSIEN
 I '$O(^YTT(601.71,YSIEN,10,0)) Q  ; no child nodes
 N DA,DIK
 S DA=0,DA(1)=YSIEN,DIK="^YTT(601.71,"_DA(1)_",10,"
 F  S DA=$O(^YTT(601.71,YSIEN,10,DA)) Q:'DA  D ^DIK
 Q
CATLST ; Instrument Categories
 ;;AAQ-2^EBP
 ;;ACE^
 ;;AD8^Pain^Cognitive
 ;;AIMS^Psychosis
 ;;ASSIST-NIDA^Screening
 ;;ASSIST-WHOV3^Screening
 ;;ATQ^Depression^EBP
 ;;AUDC^Screening^Addiction-SUD
 ;;AUDIT^Addiction-SUD
 ;;BAI^Anxiety/PTSD
 ;;BAM-C^Addiction-SUD
 ;;BAM-IOP^Addiction-SUD
 ;;BAM-R^Addiction-SUD
 ;;BARTHEL INDEX^ADL/Func Status
 ;;BASIS-24^General Symptoms^Frequent MBCs
 ;;BASIS-24 PSYCHOSIS^Psychosis
 ;;BBHI-2^Pain / Health
 ;;BDI2^Depression
 ;;BHS^Suicide Prevention
 ;;BOMC^Cognitive
 ;;BPRS^Psychosis
 ;;BPRS-A^Psychosis
 ;;BRADEN SCALE^Screening
 ;;BRS^Recovery
 ;;BSI18^Suicide Prevention
 ;;BSS^
 ;;BUSS^General Symptoms
 ;;C-SSRS^Suicide Prevention^Screening
 ;;CAGE^Addiction-SUD^Screening
 ;;CCSA-DSM5^General Symptoms
 ;;CDR^Cognitive
 ;;CEMI^EBP
 ;;CES^Anxiety/PTSD
 ;;CESD^Depression
 ;;CIWA-AR-^Addiction-SUD
 ;;CMQ^
 ;;COPD^Pain / Health
 ;;COWS^Addiction-SUD
 ;;CSDD-RS^Depression
 ;;CSI^Couples/Family Func
 ;;CSI PARTNER VERSION^Couples/Family Func
 ;;CSI-4^Couples/Family Func
 ;;CSI-4 PARTNER VERSION^Couples/Family Func
 ;;D.BAS^Sleep
 ;;D.ERS^Anxiety/PTSD
 ;;EAT-26^
 ;;EPDS^Depression
 ;;ERS^
 ;;FAST^ADL/Func Status
 ;;FFMQ^EBP
 ;;FOCI^
 ;;FTND^Pain / Health
 ;;GAD-7^Anxiety/PTSD
 ;;GAI^Anxiety/PTSD
 ;;GDS^Depression
 ;;GDS DEMENTIA^Cognitive
 ;;GPCOG^Cognitive
 ;;HSI^Pain / Health
 ;;I9+C-SSRS^Suicide Prevention^Screening
 ;;IADL^ADL/Func Status
 ;;IJSS^Employment
 ;;IMRS^Recovery
 ;;ISI^Sleep
 ;;ISMI^Recovery
 ;;ISS-2^Frequent MBCs^Depression
 ;;KATZ-ADL-18PT^
 ;;KATZ-ADL-6PT^ADL/Func Status
 ;;MBMD^Personality
 ;;MCMI3^Personality
 ;;MCMI4^Personality
 ;;MHLA^Pain / Health
 ;;MHLB^Pain / Health
 ;;MHLC-C^Pain / Health
 ;;MHRM^Recovery
 ;;MHRM-10^
 ;;MINICOG^Cognitive
 ;;MISS^Anxiety/PTSD
 ;;MMPI-2-RF^Personality
 ;;MMPI2^Personality
 ;;MOCA^Cognitive
 ;;MOCA ALT 1^Cognitive
 ;;MOCA ALT 2^Cognitive
 ;;MORSE FALL SCALE^Screening
 ;;MPI-PAIN-INTRF^Pain / Health
 ;;NEO-PI-3^Personality
 ;;PAI^Personality
 ;;PC PTSD^Anxiety/PTSD
 ;;PC-PTSD-5^Anxiety/PTSD^Screening
 ;;PC-PTSD-5+I9^Anxiety/PTSD^Screening
 ;;PCL-5^Anxiety/PTSD
 ;;PCL-5 WEEKLY^Anxiety/PTSD^Frequent MBCs
 ;;PHQ-15^Pain / Health
 ;;PHQ-2^Depression^Screening
 ;;PHQ-2+I9^Suicide Prevention^Screening
 ;;PHQ9^Depression^Frequent MBCs
 ;;POQ^Pain / Health
 ;;PROMIS29^Frequent MBCs
 ;;PSOCQ^Pain / Health
 ;;PSS^Anxiety/PTSD
 ;;PSS-3^Suicide Prevention^Screening
 ;;PSS-3 2ND^Suicide Prevention^Screening
 ;;Q-LES-Q-SF^Quality of Life
 ;;QOLI^Quality of Life
 ;;RLS^Sleep
 ;;SBR^Suicide Prevention
 ;;SCL9R^
 ;;SF36^Pain / Health
 ;;SLUMS^Cognitive
 ;;SMEQ^Sleep
 ;;SNQ^Sleep
 ;;SSF^Suicide Prevention
 ;;STAI^Anxiety/PTSD
 ;;STMS^Cognitive
 ;;STOP^Sleep
 ;;SWEMWBS^Quality of Life
 ;;VR-12^Pain / Health
 ;;VRA^Recovery
 ;;WAI-SR^Recovery^Frequent MBCs
 ;;WEMWBS^Quality of Life
 ;;WHODAS 2^ADL/Func Status
 ;;WHODAS2.0-12^ADL/Func Status
 ;;WHOQOL BREF^Quality of Life
 ;;WHYMPI^Pain / Health
 ;;ZBI SCREEN^Couples/Family Func
 ;;ZBI SHORT^Couples/Family Func
 ;;ZUNG^Depression
 ;;zzzzz
 ;
