DG53P936 ;KUM - HEALTH BENEFIT PLANS UPDATE ;1/08/17 9:18am
 ;;5.3;Registration;**936**;Aug 13, 1993;Build 20
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; KUM; DG*5.3*936 Post Install routine to add data about 6 new plans
 ;  Integration Agreements:
 ;        10141 : BMES^XPDUTL
 ;              : MES^XPDUTL
 ;        10018 : UPDATE^DIE
 ;
 Q
 ;
POST ;Update 6 Health Benefit Plans
 ;
 L +^DGHBP(25.11,0):10 I '$T D BMES^XPDUTL("     Health Benefit Plan (#25.11) File is locked by another user. Try later.   ") Q
 N HBPERR
 S HBPERR=""
 D BMES^XPDUTL("    Checking Entry in HEALTH BENEFIT PLAN File - Veteran Plan - Veterans Choice Basic   ")
 D UPDPS1
 D BMES^XPDUTL("    Checking Entry in HEALTH BENEFIT PLAN File - Veteran Plan - Veterans Choice Mileage   ")
 D UPDPS2
 D BMES^XPDUTL("    Checking Entry in HEALTH BENEFIT PLAN File - Veteran Plan - Veterans Choice Wait Time   ")
 D UPDPS3
 D BMES^XPDUTL("    Checking Entry in HEALTH BENEFIT PLAN File - Veteran Plan - VC Unusual and Excessive Burden   ")
 D UPDPS4
 D BMES^XPDUTL("    Checking Entry in HEALTH BENEFIT PLAN File - Veteran Plan - Veterans Choice Air, Boat, or Ferry   ")
 D UPDPS5
 D BMES^XPDUTL("    Checking Entry in HEALTH BENEFIT PLAN File - Veteran Plan - Military Sexual Trauma   ")
 D UPDPS6
 L -^DGHBP(25.11,0)
 Q
 ;
UPDPS1 ;Setup new Health Benefit Plan - Veteran Plan - Veterans Choice Basic
 ;
 N FIELDS,ERR
 S ERR=""
 S FIELDS("NAME")="Veteran Plan - Veterans Choice Basic"
 S FIELDS("PLANCODE")=200
 S FIELDS("COVERAGECODE")="VC01001"
 S FIELDS("SD",1)="The Veteran must be enrolled in the VA health care system and does not "
 S FIELDS("SD",2)="qualify for the Services at this time."
 S FIELDS("LD",1)="The Veteran must be enrolled in the VA health care system and does not "
 S FIELDS("LD",2)="qualify for the Services at this time."
 D UPDREQ(.FIELDS,1,.ERR)
 I ERR'="" D
 . D BMES^XPDUTL("     *** An Error occurred during updating Plan: Veteran Plan - Veterans Choice Basic.")
 . D MES^XPDUTL("     Please log CA SDM ticket.")
 . S HBPERR=ERR
 . Q
 ;
 Q
UPDPS2 ;Setup new Health Benefit Plan - Veteran Plan - Veterans Choice Mileage
 ;
 N FIELDS,ERR
 S ERR=""
 S FIELDS("NAME")="Veteran Plan - Veterans Choice Mileage"
 S FIELDS("PLANCODE")=201
 S FIELDS("COVERAGECODE")="VC01002"
 S FIELDS("SD",1)="The Veteran must be enrolled in the VA health care system.  The Veteran meets "
 S FIELDS("SD",2)="mileage criteria as described by legislation. This is calculated from the "
 S FIELDS("SD",3)="VA medical facility that is closest to the residence of the Veteran, defined "
 S FIELDS("SD",4)="as a VA hospital, community-based outpatient clinic, or VA health care center "
 S FIELDS("SD",5)="with at least one full-time primary care physician. The distance is calculated "
 S FIELDS("SD",6)="using driving distance."
 S FIELDS("LD",1)="The Veteran must be enrolled in the VA health care system.  The Veteran meets "
 S FIELDS("LD",2)="mileage criteria as described by legislation. This is calculated from the "
 S FIELDS("LD",3)="VA medical facility that is closest to the residence of the Veteran, defined "
 S FIELDS("LD",4)="as a VA hospital, community-based outpatient clinic, or VA health care center "
 S FIELDS("LD",5)="with at least one full-time primary care physician. The distance is calculated "
 S FIELDS("LD",6)="using driving distance."
 D UPDREQ(.FIELDS,1,.ERR)
 I ERR'="" D
 . D BMES^XPDUTL("     *** An Error occurred during updating Plan: Veteran Plan - Veterans Choice Mileage.")
 . D MES^XPDUTL("     Please log CA SDM ticket.")
 . S HBPERR=ERR
 . Q
 ;
 Q
UPDPS3 ;Setup new Health Benefit Plan - Veteran Plan - Veterans Choice Wait Time
 ;
 N FIELDS,ERR
 S ERR=""
 S FIELDS("NAME")="Veteran Plan - Veterans Choice Wait Time"
 S FIELDS("PLANCODE")=202
 S FIELDS("COVERAGECODE")="VC01003"
 S FIELDS("SD",1)="The Veteran must be enrolled in the VA health care system. Veteran is told "
 S FIELDS("SD",2)="by his/her local VA medical facility that he/she will need to wait more than "
 S FIELDS("SD",3)="30 days for an appointment from the date clinically determined by his/her "
 S FIELDS("SD",4)="VA health care provider or the date they wish to be seen if there is no "
 S FIELDS("SD",5)="clinically determined date."
 S FIELDS("LD",1)="The Veteran must be enrolled in the VA health care system. Veteran is told "
 S FIELDS("LD",2)="by his/her local VA medical facility that he/she will need to wait more than "
 S FIELDS("LD",3)="30 days for an appointment from the date clinically determined by his/her "
 S FIELDS("LD",4)="VA health care provider or the date they wish to be seen if there is no "
 S FIELDS("LD",5)="clinically determined date."
 D UPDREQ(.FIELDS,1,.ERR)
 I ERR'="" D
 . D BMES^XPDUTL("     *** An Error occurred during updating Plan: Veteran Plan - Veterans Choice Wait Time")
 . D MES^XPDUTL("     Please log CA SDM ticket.")
 . S HBPERR=ERR
 . Q
 ;
 Q
UPDPS4 ;Setup new Health Benefit Plan - Veteran Plan - VC Unusual and Excessive Burden
 ;
 N FIELDS,ERR
 S ERR=""
 S FIELDS("NAME")="Veteran Plan - VC Unusual and Excessive Burden"
 S FIELDS("PLANCODE")=203
 S FIELDS("COVERAGECODE")="VC01004"
 S FIELDS("SD",1)="The Veteran must be enrolled in the VA health care system. The Veteran who "
 S FIELDS("SD",2)="resides 40 miles or less from the nearest VA medical facility may face an "
 S FIELDS("SD",3)="unusual or excessive burden in accessing such a facility based on: "
 S FIELDS("SD",4)=". Geographical challenges"
 S FIELDS("SD",5)=". Environmental factors such as:"
 S FIELDS("SD",6)=" o Roads that are not accessible to the general public, such as a road through "
 S FIELDS("SD",7)="   a military base or restricted area"
 S FIELDS("SD",8)=" o Traffic, or"
 S FIELDS("SD",9)=" o Hazardous weather conditions"
 S FIELDS("SD",10)=". A medical condition that impacts the ability to travel"
 S FIELDS("SD",11)=". Other factors (as determined by the Secretary of VA)"
 S FIELDS("LD",1)="The Veteran must be enrolled in the VA health care system. The Veteran who "
 S FIELDS("LD",2)="resides 40 miles or less from the nearest VA medical facility may face an "
 S FIELDS("LD",3)="unusual or excessive burden in accessing such a facility based on: "
 S FIELDS("LD",4)=". Geographical challenges"
 S FIELDS("LD",5)=". Environmental factors such as:"
 S FIELDS("LD",6)=" o Roads that are not accessible to the general public, such as a road through "
 S FIELDS("LD",7)="   a military base or restricted area"
 S FIELDS("LD",8)=" o Traffic, or"
 S FIELDS("LD",9)=" o Hazardous weather conditions"
 S FIELDS("LD",10)=". A medical condition that impacts the ability to travel"
 S FIELDS("LD",11)=". Other factors (as determined by the Secretary of VA)"
 D UPDREQ(.FIELDS,1,.ERR)
 I ERR'="" D
 . D BMES^XPDUTL("     *** An Error occurred during updating Plan: Veteran Plan - Veterans Choice Wait Time")
 . D MES^XPDUTL("     Please log CA SDM ticket.")
 . S HBPERR=ERR
 . Q
 ;
 Q
UPDPS5 ;Setup new Health Benefit Plan - Veteran Plan - Veterans Choice Air, Boat, or Ferry
 ;
 N FIELDS,ERR
 S ERR=""
 S FIELDS("NAME")="Veteran Plan - Veterans Choice Air, Boat, or Ferry"
 S FIELDS("PLANCODE")=204
 S FIELDS("COVERAGECODE")="VC01005"
 S FIELDS("SD",1)="The Veteran must be enrolled in the VA health care system. The Veteran who "
 S FIELDS("SD",2)="resides 40 miles or less from the nearest VA medical facility and must travel "
 S FIELDS("SD",3)="by air, boat, or ferry to reach such a facility."
 S FIELDS("LD",1)="The Veteran must be enrolled in the VA health care system. The Veteran who "
 S FIELDS("LD",2)="resides 40 miles or less from the nearest VA medical facility and must travel "
 S FIELDS("LD",3)="by air, boat, or ferry to reach such a facility."
 D UPDREQ(.FIELDS,1,.ERR)
 I ERR'="" D
 . D BMES^XPDUTL("     *** An Error occurred during updating Plan: Veteran Plan - Veterans Choice Air, Boat, or Ferry    ;")
 . D MES^XPDUTL("     Please log CA SDM ticket.")
 . S HBPERR=ERR
 . Q
 ;
 Q
UPDPS6 ;Setup new Health Benefit Plan - Veteran Plan - Military Sexual Trauma
 ;
 N FIELDS,ERR
 S ERR=""
 S FIELDS("NAME")="Veteran Plan - Military Sexual Trauma"
 S FIELDS("PLANCODE")=205
 S FIELDS("COVERAGECODE")="MS01001"
 S FIELDS("SD",1)=""
 S FIELDS("LD",1)=""
 D UPDREQ(.FIELDS,1,.ERR)
 I ERR'="" D
 . D BMES^XPDUTL("     *** An Error occurred during updating Plan: Veteran Plan - Military Sexual Trauma    ;")
 . D MES^XPDUTL("     Please log CA SDM ticket.")
 . S HBPERR=ERR
 . Q
 ;
 Q
UPDREQ(FIELDS,NEW,ERR) ; Update entries in the HEALTH BENEFIT PLAN File (25.11)
 ;
 ;  Input: FIELDS - Array of Field Values
 ;            NEW - 0 to edit, 1 to create new entry
 ;
 ;  Output:   ERR - Error Text
 ;
 N IEN,NAME,PLANCODE,COVERAGECODE,SD,LD,FDA,DGPFMSG,DGPFMS1
 K ERR
 S ERR=""
 S NAME=$G(FIELDS("NAME"))
 S PLANCODE=$G(FIELDS("PLANCODE"))
 M SD=FIELDS("SD")
 M LD=FIELDS("LD")
 S COVERAGECODE=$G(FIELDS("COVERAGECODE"))
 I NAME="" S ERR="Missing Health Benefit Plan Name" Q
 I NEW D  Q:ERR'="" 
 . I PLANCODE="" S ERR="Missing Plan Code" Q
 . I '$D(SD) S ERR="Missing Short Description" Q
 . I '$D(LD) S ERR="Missing Long Description" Q
 . I COVERAGECODE="" S ERR="Missing Coverage Code" Q
 . Q
 ;
 ; Check if entry exists, use it if it does
 S IEN=$O(^DGHBP(25.11,"B",NAME,0))
 I IEN D BMES^XPDUTL("    "_NAME_" already exists, no action is taken.  ") Q
 I NEW,'IEN S IEN="+1"
 I 'NEW,'IEN S ERR="Health Benefit Plan Not Defined" Q 0
 S IEN=IEN_","
 ;
 S FDA(25.11,IEN,.01)=NAME
 S:PLANCODE'="" FDA(25.11,IEN,.02)=PLANCODE
 S:COVERAGECODE'="" FDA(25.11,IEN,.05)=COVERAGECODE
 D UPDATE^DIE("E","FDA","","ERR")
 I $D(ERR("DIERR")) S ERR=$G(ERR("DIERR",1,"TEXT",1)) Q
 S IEN=$O(^DGHBP(25.11,"B",NAME,0))
 I 'IEN D BMES^XPDUTL("    "_IEN_" entry is not found to update Short and Long Descripton fields.  ") Q
 D WP^DIE(25.11,IEN_",",.03,"","SD","DGPFMSG") ; SHORT DESCRIPTION
 I $D(DGPFMSG) S ERR=$G(DGPFMSG("DIERR",1,"TEXT",1)) Q
 D WP^DIE(25.11,IEN_",",.04,"","LD","DGPFMS1") ; LONG DESCRIPTION
 I $D(DGPFMS1) S ERR=$G(DGPFMS1("DIERR",1,"TEXT",1)) Q
 D BMES^XPDUTL("    "_NAME_" is added in HEALTH BENEFIT PLAN File.    ")
 Q
 ;
