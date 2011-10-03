PSSP110 ; Post init routine for patch PSS*1*110 03/30/2006 4:57P
 ;;1.0;PHARMACY DATA MANAGEMENT;**110**;9/30/97
 Q
EN ; Entry point
 ; Convert the NAME field in files #51 & 51.1 to all CAPS
 ;
 N DD,D0,DA,DIE,DR,PSSI,PSSJ,PSSCNT,PSSTXT,PSSLN,PSSAST
 N XMDUZ,XMSUB,XMTEXT,XMY,DIFROM,PSSFLG
 I $G(U)="" S U="^"
 S XMDUZ="PSS*1*110 Post Init",XMY(DUZ)=""
 ;
 ; File 51 (Medication Instruction)
 S DIE="^PS(51,"
 D CON
 S XMSUB="File #51 modified records"
 D MSG1
 ;
 ; File 51.1 (Administration Schedule)
 S DIE="^PS(51.1,"
 D CON
 S XMSUB="File #51.1 modified records"
 D MSG1
 ;
 ; File 51.2 (Medication Routes)
 ;S XMSUB="File #51.2 'to be' modified records"
 ;D COM
 G ENQ
 ;
CON ; Convert ONLY lowercase alphabet to uppercase.  All other characters
 ; in the NAME field are left alone.
 S PSSI="",PSSCNT=0,PSSLN=2,PSSFLG=""
 F  S PSSI=$O(@(DIE_"""B"""_",PSSI)")) Q:PSSI=""  D
 . I PSSI'?.E1L.E Q  ; No lowercase in the NAME, no need to convert
 . S PSSJ=$$UP^XLFSTR(PSSI),PSSAST="*"
 . I '$O(@(DIE_"""B"""_",PSSJ,0)")) D
 . . S DA=$O(@(DIE_"""B"""_",PSSI,0)")),DR=".01///"_PSSJ
 . . D ^DIE
 . . S PSSAST=""
 . E  S PSSFLG=1
 . S PSSCNT=PSSCNT+1
 . S PSSLN=PSSLN+1,PSSTXT(PSSLN)=PSSAST_PSSI
 Q
COM ; Compile a list of all medication routes that do NOT
 ; have an abbreviation and send it to DUZ.
 S PSSI="",PSSCNT=0,PSSLN=2
 F  S PSSI=$O(^PS(51.2,PSSI)) Q:PSSI']""  D
 . I '$D(^PS(51.2,PSSI,0)) Q
 . S PSSJ=$G(^PS(51.2,PSSI,0))
 . I $P(PSSJ,U,3)']"" D
 . . S PSSCNT=PSSCNT+1,PSSLN=PSSLN+1
 . . S PSSTXT(PSSLN)=$P(PSSJ,U,1)
 I PSSCNT<1 D  Q
 . S PSSTXT(1)="All medication routes have abbreviations!"
 . D SEND
 S PSSTXT(1)="The following medication route/s does/do not"
 S PSSTXT(2)="have a corresponding abbreviation:"
 D SEND
 Q
MSG1 ; Send message to user DUZ for files 51 & 51.1
 I PSSCNT<1 D  Q
 . S PSSTXT(1)="No NAME conversion was neccessary!"
 . D SEND
 S PSSTXT(1)="The following NAME/s was/were converted"
 S PSSTXT(2)="from lowercase to uppercase:"
 I PSSFLG=1 D
 . S PSSLN=PSSLN+1
 . S PSSTXT(PSSLN)="Record/s marked with an '*' was/were skipped."
 . S PSSLN=PSSLN+1
 . S PSSTXT(PSSLN)="Conversion to uppercase would have created a"
 . S PSSLN=PSSLN+1
 . S PSSTXT(PSSLN)="duplicate NAME.  Please check!!"
 D SEND
 Q
SEND ;
 S XMTEXT="PSSTXT(",XMDUZ="PSS*1*110 Post Init",XMY(DUZ)=""
 D ^XMD
 K PSSTXT
ENQ Q
