GMRAMCU0 ;HIRMFO/WAA-ID BAND/CHART MARKING UTILITIES ; 2/13/95
 ;;4.0;Adverse Reaction Tracking;;Mar 29, 1996
 ;
IDBAND(DFN,DATE,USR) ; This program will mark all the ID Band fields for
 ; all reactions for a patient
 ;
 ; INPUT
 ;         DFN = IEN for a patient in file 2 (Required)
 ;        DATE = Date of marking in File Manager format (optional-
 ;               if undefined or null current date/time will be used).
 ;         USR = User Marking the ID band (optional- if undefined null
 ;               will be used indicating data automatically entered).
 ;
 N GMRADT,GMRAPA,GMRAUSR
 S GMRADT=$G(DATE),GMRAUSR=$G(USR)
 I GMRADT="" S GMRADT=$$HTFM^XLFDT($H)
 S X=GMRADT,%DT="TS" D ^%DT S GMRADT=Y
 Q:$G(DFN)<1!(GMRADT<0)!(GMRAUSR'=""&(GMRAUSR'>0))
 S GMRAPA=0 F  S GMRAPA=$O(^GMR(120.8,"B",DFN,GMRAPA)) Q:GMRAPA<1  D
 .Q:$P($G(^GMR(120.8,GMRAPA,0)),U,2)=""!+$G(^GMR(120.8,GMRAPA,"ER"))
 .N DA,DD,DO,DIC,DIE,DINUM,DR
 .S DIC="^GMR(120.8,"_GMRAPA_",14,",DIC(0)="L",DIC("P")="120.814DA",DLAYGO=120.8,DA(1)=GMRAPA,X=GMRADT D FILE^DICN K DA,DIC
 .I Y>0,GMRAUSR'="" D
 ..S DA(1)=GMRAPA,DA=+Y,DIE="^GMR(120.8,"_DA(1)_",14,",DR="1////"_GMRAUSR
 ..D ^DIE
 ..Q
 .Q
 Q
