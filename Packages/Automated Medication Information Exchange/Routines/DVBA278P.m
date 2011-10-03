DVBA278P ;ALB/GTS - PATCH DVBA*2.7*8 TO CLEANUP 396.1 DD ; 4/29/96
 ;;2.7;AMIE;**8**;Apr 10, 1995
 ;
TEXT ; write lines for user
 ;; This routine will loop through all fields in the AMIE SITE PARAMETER
 ;; file looking for fields not supported with class I software.  When
 ;; such a field is found, the installer will be asked if they want to
 ;; delete the field.  When all fields are checked, a message will be
 ;; sent to the installer indicating what they selected to delete.
 ;; This message serves as record of what was selected for a particular
 ;; install and can be used to check if existing class III fields are
 ;; needed.  The user may abort the install by entering an '^' at
 ;; the Device selection prompt.  If you are unsure that the fields
 ;; you have selected for deletion are not used by any class III
 ;; programming at your site, PLEASE '^' AT THE DEVICE SELECTION
 ;; PROMPT AND REVIEW THE MAIL MESSAGE THAT IS DELIVERED.  You may
 ;; rerun the install at any time after you have reviewed the mail
 ;; message.
 ;; 
 ;;QUIT
 ;
ENVCHKQ QUIT  ;** Quit the environment check.  Only called so routine is
 ;      ** available from Pre-Init questions.
 ;
QUEST ;** Entry point - Question Class III fields
 N TXTVAR
 D KVARS
 D MES^XPDUTL(" "),MES^XPDUTL(" ")
 F I=1:1 S TXTVAR=$P($T(TEXT+I),";;",2) Q:TXTVAR="QUIT"  DO
 .S:TXTVAR="" TXTVAR=" "
 .D MES^XPDUTL(TXTVAR)
 D START
 Q
 ;
 ;
START ;** Start processing
 S (I,NODE,COUNT,QUESDA)=0
 ;
 ;** Look for unsupported fields
 D MES^XPDUTL(" ")
 D MES^XPDUTL("Inspecting file 396.1 for unsupported fields.")
 ;
 ;** Class I fld array
 F FILE=396.1,396.12,396.13,396.14,396.115 DO
 .F I=(I+1):1 S FIELDVAR=$P($T(FIELDS+I),";;",2) Q:(FIELDVAR="QUIT")  DO
 ..S CLASSI(FILE,FIELDVAR)=""
 ;
 ;** Fields at site
 F FILE=396.1,396.12,396.13,396.14,396.115 DO
 .F FLDDA=0:0 S FLDDA=$O(^DD(FILE,FLDDA)) Q:'FLDDA  DO
 ..I $D(^DD(FILE,FLDDA,0)),'$D(CLASSI(FILE,FLDDA)) DO
 ...S CLASSIII(FILE,FLDDA)=$P(^DD(FILE,FLDDA,0),"^",1)_"^"_$P(^(0),"^",4)
 ;
 ;** If no Class III fields
 I '$D(CLASSIII) DO
 .D MES^XPDUTL(" ")
 .D MES^XPDUTL(".....no unsupported fields were found!")
 ;
 ;** Nullify all XPDQUES nodes
 S QUESSUB=""
 F  S QUESSUB=$O(XPDQUES(QUESSUB)) Q:(QUESSUB']"")  DO
 .S XPDQUES(QUESSUB)=""
 .S XPDQUES(QUESSUB,"A")=""
 ;
 ;** Set up XPDQUES nodes
 S FILE=""
 F  S FILE=$O(CLASSIII(FILE)) Q:('FILE!($D(DVBAOUT)))  DO
 .S FLDDA=""
 .F  S FLDDA=$O(CLASSIII(FILE,FLDDA)) Q:('FLDDA!($D(DVBAOUT)))  DO
 ..W !!!,?1,"Field #",?12,"Field Name",?45,"Node;Piece"
 ..W !,?3,FLDDA
 ..W ?12,$P(CLASSIII(FILE,FLDDA),U,1)
 ..W ?48,$P(CLASSIII(FILE,FLDDA),U,2)
 ..S DIR(0)="YAO^",DIR("A")="Do you want to delete this field? "
 ..S DIR("B")="YES" D ^DIR
 ..I $D(DTOUT)!($D(DUOUT)!($D(DIROUT))) S DVBAOUT=""
 ..I '$D(DVBAOUT)&(+Y=1) DO
 ...S QUESDA=QUESDA+1
 ...S QUESSUB="PRE"_QUESDA
 ...S XPDQUES(QUESSUB)=$P(CLASSIII(FILE,FLDDA),U,1)_"^"_FLDDA_"^"_FILE
 ...S XPDQUES(QUESSUB,"A")=$P(CLASSIII(FILE,FLDDA),U,1)_" selected for deletion!"
 ..K DIR,X,Y
 I $D(DVBAOUT) K XPDQUES
 I '$D(DVBAOUT) D MAIL
KVARS K COUNT,DFN,I,NODE,NODENM,FIELDVAR,FLDDA,FILE,QUESDA
 K CLASSI,CLASSIII,DVBAOUT
 K DTOUT,DUOUT,DIROUT
 Q
 ;
MAIL ; mail message of bogus nodes found
 N DIFROM
 S XMY(DUZ)="",XMDUZ=.5
 S XMSUB="AMIE SITE PARAMETER file field cleanup"
 S XMTEXT="^TMP(""DVBA V2.7 P8 E-MAIL"","_$J_","
 S I=0,COUNT=0
 S TEXT="This Mailman message records the Class III fields selected for deletion"
 D LINE(TEXT)
 S TEXT=" with patch DVBA*2.7*8.  These fields are only deleted if/when the"
 D LINE(TEXT)
 S TEXT=" installation was/is completed."
 D LINE(TEXT)
 D LINE(" ")
 S TEXT=" The following fields were selected to delete from the AMIE SITE"
 D LINE(TEXT)
 S TEXT="   PARAMETER file (#396.1) (Multiples included):"
 D LINE(TEXT)
 D LINE(" ")
 I '$D(XPDQUES) DO
 .S TEXT="     No fields selected for deletion!"
 .D LINE(TEXT)
 I $D(XPDQUES("PRE1")),(XPDQUES("PRE1")="") DO
 .S TEXT="     No fields selected for deletion!"
 .D LINE(TEXT)
 I $D(XPDQUES("PRE1")),(XPDQUES("PRE1")'="") DO
 .S TEXT="   FIELD NAME                        FIELD #        FILE #"
 .D LINE(TEXT)
 .S TEXT="   ==========                        =======        ======"
 .D LINE(TEXT)
 .S I="PRE0"
 .F  S I=$O(XPDQUES(I)) Q:(I']"")  D
 ..S (BLANK1,BLANK2)=""
 ..S $P(BLANK1," ",(37-$L($P(XPDQUES(I),"^",1))))=""
 ..S TEXT="   "_$P(XPDQUES(I),"^",1)_BLANK1_$P(XPDQUES(I),"^",2)
 ..S $P(BLANK2," ",(53-$L(TEXT)))=""
 ..S TEXT=TEXT_BLANK2_$P(XPDQUES(I),"^",3)
 ..D LINE(TEXT)
 D ^XMD
 K XMDUZ,XMY,XMTEXT,XMSUB,BLANK1,BLANK2,TEXT,QUESSUB
 K ^TMP("DVBA V2.7 P8 E-MAIL",$J)
 Q
 ;
 ;
LINE(TEXT)      ; add line to array for e-mail
 S COUNT=COUNT+1,^TMP("DVBA V2.7 P8 E-MAIL",$J,COUNT)=TEXT
 Q
 ;
FLDCLEAN ;**Delete selected fields
 I $D(XPDQUES) DO
 .N I,SITEDA,MULTDA,FLDDA,FILEDA1,NODE,CLEANFLD
 .S SITEDA=0
 .S SITEDA=$O(^DVB(396.1,SITEDA))
 .S I="PRE0"
 .F  S I=$O(XPDQUES(I)) Q:(I']"")  Q:(XPDQUES(I)="")  D
 ..S FILEDA1=$P(XPDQUES(I),"^",3)
 ..S FLDDA=$P(XPDQUES(I),"^",2)
 ..;
 ..;** Remove data in fields deleted
 ..I FILEDA1=396.1 DO
 ...S DIE="^DVB(396.1,",DA=SITEDA
 ...S DR=FLDDA_"////@"
 ...D ^DIE
 ...K DIE,DA,DR
 ..I FILEDA1'=396.1 DO
 ...S (CLEANFLD,MULTDA)=0
 ...S MULTDA=$O(^DD(396.1,"SB",FILEDA1,0))
 ...S:MULTDA CLEANFLD=1,NODE=$P($P(^DD(396.1,MULTDA,0),"^",4),";",1)
 ...I CLEANFLD DO
 ....S MULTDA=0
 ....F  S MULTDA=$O(^DVB(396.1,SITEDA,NODE,MULTDA)) Q:'MULTDA  DO
 .....S DIE="^DVB(396.1,"_SITEDA_","_NODE_","
 .....S DA=MULTDA,DA(1)=SITEDA
 .....S DR=FLDDA_"////@"
 .....D ^DIE
 .....K DIE,DA,DR
 ..;
 ..;** Remove from DD
 ..S DA=FLDDA
 ..S DA(1)=FILEDA1
 ..S DIK="^DD("_DA(1)_","
 ..D ^DIK
 ..K DA,DIK
 Q
 ;
FIELDS ; list of fields in 396.1
 ;;.01
 ;;.11
 ;;2
 ;;3
 ;;4
 ;;6
 ;;7
 ;;8
 ;;9
 ;;10
 ;;11
 ;;12
 ;;14
 ;;15
 ;;16
 ;;17
 ;;18
 ;;50
 ;;90
 ;;QUIT
P12 ;;.01
 ;;QUIT
P13 ;;.01
 ;;1
 ;;QUIT
P14 ;;.01
 ;;1
 ;;QUIT
P115 ;;.01
 ;;QUIT
