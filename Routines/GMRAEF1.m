GMRAEF1 ;HIRMFO/WAA-FDA EXCEPTION REPORT ; 11/25/92
 ;;4.0;Adverse Reaction Tracking;;Mar 29, 1996
EN1 ; Entry to PRINT PATIENT FDA EXCEPTION DATA option
 K DIC S GMRAOUT=0
 W ! S DIC="^DPT(",DIC(0)="AEQM"
 D ^DIC K DIC,DLAYGO G:+Y'>0 EN1Q
 S GMRDFN=+Y D EN2 G:'GMRAOUT EN1
EN1Q K GMRDFN,DIC,GMRAOUT
 D KILL^XUSCLEAN G EXIT
EN2 ;
 S GMRAX=$P($G(^GMR(120.86,GMRDFN,0)),U,2) I GMRAX=0 W !,"This patient has No Known Allergies" K GMRAX Q
 S X=0 F X=0:0 S X=$O(^GMR(120.8,"B",GMRDFN,X)) Q:X'>0  I '+$G(^GMR(120.8,X,"ER")) S X=X+1 Q
 I 'X W !,"This patient has no allergies on file" Q
DDATE ;Select discharge date
 K DIR S DIR("A")="Enter the Date to start search (Time optional)"
 S DIR("B")="T-30",DIR(0)="DO^::AET"
 S DIR("?")="ENTER THE DATE YOU WANT THE SYSTEM TO START IT'S SEARCH"
 D ^DIR K DIR
 I "^^"[Y S GMRAOUT=1 G EXIT
 I $D(DIRUT) G EXIT
 S GMRASTDT=Y
 S GMRAIEN=0 F  S GMRAIEN=$O(^GMR(120.8,"B",GMRDFN,GMRAIEN)) Q:GMRAIEN<1  D
 .Q:+$G(^GMR(120.8,GMRAIEN,"ER"))
 .S GMRA(0)=$G(^GMR(120.8,GMRAIEN,0))
 .Q:GMRA(0)=""
 .I $P(GMRA(0),U,6)'="o"!($P(GMRA(0),U,20)'["D") Q
 .I '$P(GMRA(0),U,12) Q
 .I $P(GMRA(0),U,4)<GMRASTDT Q
 .I $$CMPFDA(GMRAIEN) Q
 .S GMRABGDT=$P(GMRA(0),U,4)
 .S ^TMP($J,"GMRAEF",GMRDFN,GMRABGDT)=GMRAIEN
 .Q
 D EN1^GMRAEF
 Q
CMPFDA(DA) ; GIVEN DA ENTRY IN 120.8 RETURN 0 IF THERE IS INCOMPLETE
 ; FDA DATA, ELSE RETURN 1
 N X
 S X=0,Y=0 ; Pre set quit flag to valid
 ;loop through for each entry
 F  S X=$O(^GMR(120.85,"C",DA,X)) Q:X'>0  D  Q:'Y
 .S X(0)=$G(^GMR(120.85,X,0)) ; get the zero node
 .; Required data
 .I $P(X(0),U)="" Q  ; Date/Time of Event
 .I $P(X(0),U,2)="" Q  ; Patient
 .I $P(X(0),U,18)="" Q  ; Date Reported
 .I $P(X(0),U,19)="" Q  ; Reporting User
 .I '$O(^GMR(120.85,X,2,0)) Q  ; Reaction
 .I '$O(^GMR(120.85,X,3,0)) Q  ; Suspected Agent
 .S Y=1
 .I $P(X(0),U,3)'="" Q  ; Question 1
 .I $P(X(0),U,4)'="" Q  ; Question 2
 .I $P(X(0),U,5)'="" Q  ; Question 3
 .I $P(X(0),U,6)'="" Q  ; Question 4
 .I $P(X(0),U,7)'="" Q  ; Question 5
 .I $P(X(0),U,9)'="" Q  ; Question 6
 .I $P(X(0),U,10)'="" Q  ; Question 7
 .I $P(X(0),U,11)'="" Q  ; Question 8
 .I $P(X(0),U,16)'="" Q  ; Question 9
 .I $P(X(0),U,17)'="" Q  ; Question 10
 .S Y=0
 .Q
 Q Y
EXIT ;EXIT OF ROUTINE
 K DIC
 Q
