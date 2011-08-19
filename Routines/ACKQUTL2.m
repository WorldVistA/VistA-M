ACKQUTL2 ;AUG/JLTP BIR/PTD HCIOFO/AG -QUASAR Utility Routine ; [ 04/25/96 10:03 ]
 ;;3.0;QUASAR;**15**;Feb 11, 2000;Build 2
 ;Per VHA Directive 10-93-142, this routine SHOULD NOT be modified.
 ;
 ;
DIVLIST(ACKTYP,ACKTXT) ; list on screen all the Divisions on the Site Parameter File
 ; optional ACKTYP = type of list 1=Active only, 0 (default) = all
 ; optional ACKTXT = preceding message
 N ACKFROM,ACKFDA,ACKMSG,ACKSCRN,DIWL,DIWR,DIWF,X,Y,I,DA,ACKCT
 S ACKFROM="",ACKTYP=$S(+$G(ACKTYP)=1:1,1:0)
 ; set up the screen if only active divisions are to be listed
 S ACKSCRN=$S(ACKTYP=1:"I $P(^(0),U,2)=""A""",1:"")
 ; call fileman to retrieve the Divisions
 D LIST^DIC(509850.83,",1,",".01;.02","","",.ACKFROM,"","",ACKSCRN,"","ACKFDA","ACKMSG")
 ; get count of number of Divisions
 S ACKCT=$P(ACKFDA("DILIST",0),U,1)
 ; determine the text header
 I ACKCT=0,ACKTYP=0 S ACKTXT="  No Divisions have been set up."
 I ACKCT=0,ACKTYP=1 S ACKTXT="  There are no Active Divisions on file."
 I $G(ACKTXT)="" D
 . I ACKCT>0 S ACKTXT="  The following Divisions have been set up..."
 ;
 ; the following section uses DIWP & DIWW to format and output the text
 S DIWL=5,DIWR=75,DIWF=""
 S X="|SETTAB(10,40)| " D ^DIWP
 S X=" " D ^DIWP   ;blank line!
 S X=ACKTXT D ^DIWP
 ; now output each Division
 F ACK=1:1:ACKCT D
 . ; print division name
 . S X="  |TAB|"_$E(ACKFDA("DILIST",1,ACK),1,25)
 . ; if all divisions to be printed then also print the status
 . I ACKTYP=0 S X=X_"|TAB|"_$$MC(ACKFDA("DILIST","ID",ACK,.02))
 . D ^DIWP
 ; now write to the screen
 D ^DIWW
 ;
 ; end
 Q
 ;
MC(X) ; convert X to mixed case (1st upper, remainder lower)
 N UP,LW S UP="ABCDEFGHIJKLMNOPQRSTUVWXYZ",LW="abcdefghijklmnopqrstuvwxyz"
 Q $TR($E(X),LW,UP)_$TR($E(X,2,999),UP,LW)
 ;
 ;
DIV(ACKTYP,ACKDIV,ACKSTA) ; prompt user for an A&SP Division
 ;  where ACKTYP can be 1=one div, 2=many, 3=many/all
 ;  if ACTYPE>1 then ACKDIV must be passed in by reference
 ;  and ACKSTA contains the required status of the Division
 ;  so if ACKSTA="A" then only active divisions may be chosen
 ;   if ACKSTA="I" then only inactive divisions may be chosen
 ;   if ACKSTA="AI" or "IA" then either active or inactive may be 
 ;    chosen. If not passed then "A" is used as the default.
 ; ------------------------------------------------------------
 ; function returns:-
 ;   ACKDIV=a^b   where a=no. divisions selected, and b=total
 ;        available divisions.
 ;        (if the user quits or times out then a=0)
 ;   ACKDIV(x)=x^y^z  where 
 ;         x=div ien on Med Cen Div file #40.8,
 ;         y=div ien on Site Parameters #509850.83
 ;     and z=division name
 ; ------------------------------------------------------------
 N DIVARR,ACKDIVN,ACKN,ACKDEF,ACKDFLT,ACKIEN,ACKX
 K ACKDIV
 ; initialise selected Division
 S ACKDIV=""
 ;
 ; check parameter has been passed in
 I "1/2/3"'[+$G(ACKTYP) G DIVX
 ;
 ; get list of divisions
 D GETDIV^ACKQRU(.DIVARR,$G(ACKSTA),"U")
 ;
 ; no Divisions exist
 I DIVARR<1 S ACKDIV=0 G DIVX
 ;
 ;  only one Division exists 
 I DIVARR=1 D  G DIVX
 . S ACKDIV="1^1",ACKDIV($P(DIVARR(1,1),U,1))=$P(DIVARR(1,1),U,1,3)_U
 ;
 ; get last Division selected by the user (spacebar recall)
 S ACKDEF=$$FIND1^DIC(509850.83,",1,",""," ")
 S ACKDEF=$S(ACKDEF:$$EXTERNAL^DILFD(509850.83,".01","",ACKDEF),1:"")
 S ACKDEF=$$UC(ACKDEF) ; convert to uppercase
 I ACKDEF'="",'$D(DIVARR(2,ACKDEF)) S ACKDEF=""
 S ACKDFLT=$S(ACKDEF="":"",1:"2^"_ACKDEF)
 ;
 ; multiple divisions exist, only one required.
 I ACKTYP=1,DIVARR>1 D  G DIVX
 . D SELECT^ACKQSEL(1,"DIVARR(2)","DIVARR(4)","DIVISION^35","D DIVHLP^ACKQUTL2",ACKDFLT)
 . ; get Division IEN
 . I $O(DIVARR(4,""))="" S ACKDIV="0^"_DIVARR Q  ; either quit or timed out
 . S ACKDIVN=$O(DIVARR(4,"")),ACKN=DIVARR(2,ACKDIVN)
 . S ACKIEN=$P(DIVARR(1,ACKN),U,1)
 . D RECALL^DILFD(509850.83,ACKIEN_",1,",DUZ) ; save for spacebar recall
 . S ACKDIV="1^"_DIVARR
 . S ACKDIV(ACKIEN)=$P(DIVARR(1,ACKN),U,1,3)_U
 ;
 ; multiple divisions exist, user may select one/many or ALL.
 I ACKTYP>1,DIVARR>1 D  G DIVX
 . D SELECT^ACKQSEL(ACKTYP,"DIVARR(2)","DIVARR(4)","DIVISION^35","D DIVHLP^ACKQUTL2",ACKDFLT)
 . ; get Division IEN
 . I $G(DIVARR(4))'="" S ACKDIV="0^"_DIVARR Q  ;either quit or timed out
 . S ACKDIV=U_DIVARR
 . S ACKX="" F  S ACKX=$O(DIVARR(4,ACKX)) Q:ACKX=""  D
 . . S $P(ACKDIV,U,1)=$P(ACKDIV,U,1)+1,ACKN=DIVARR(2,ACKX)
 . . S ACKDIV($P(DIVARR(1,ACKN),U,1))=$P(DIVARR(1,ACKN),U,1,3)_U
 . ; if only one selected then save for spacebar recall
 . I +$P(ACKDIV,U,1)=1 D
 . . S ACKIEN=$O(ACKDIV("")) Q:'ACKIEN
 . . D RECALL^DILFD(509850.83,ACKIEN_",1,",DUZ) ; save for spacebar recall
 ;
DIVX ; end
 Q ACKDIV
 ;
 ;
DIVHLP ; displays help text for the Division prompt
 N X,DIWL,DIWR,DIWF
 S DIWL=1,DIWR=80,DIWF=""
 S X="     " D ^DIWP
 S X="    Enter the name of a Division from the A&SP Site Parameters File." D ^DIWP
 S X="    Enter '??' to see a list of the available Divisions, '^' to exit." D ^DIWP
 D ^DIWW
 Q
LEADROLE(ACKVIEN) ; determine lead role for a visit
 ;  prior to version 3.0 all visits would be filed with a Lead Role
 ;  entered by the user (either the primary clinician, secondary
 ;  clinician or other prov). With ver 3.0 this field is no longer
 ;  populated and the lead role is the primary provider, or if absent
 ;  the secondary provider. In order to be backward compatible this
 ;  function will check the lead role field first. If it contains a 
 ;  value then the visit must be pre-ver 3.0 and this code must be
 ;  the lead role selected by the user. If the lead role field is
 ;  empty then the visit must be post-ver 3.0 and so this function
 ;  will return either the primary or secondary provider.
 N ACKSECV2,ACKTGT,ACKMSG,ACKLEAD,ACKIENS,ACKPRIM,ACKSCND,ACKSTUD,ACKMSG1,ACKTGT1
 N ACK2
 S ACKIENS=ACKVIEN_","
 D GETS^DIQ(509850.6,ACKIENS,".25;.27;6","I","ACKTGT","ACKMSG")
 S ACKLEAD=ACKTGT(509850.6,ACKIENS,.27,"I")   ; Lead role (Pre V.3.)
 I +ACKLEAD>0 Q +ACKLEAD
 S ACKPRIM=ACKTGT(509850.6,ACKIENS,6,"I")     ; Primary clinician
 I +ACKPRIM>0 Q +ACKPRIM
 S ACKSECV2=ACKTGT(509850.6,ACKIENS,.25,"I")  ; Pre V.3 Sec'dry clinician
 I +ACKSECV2>0 Q +ACKSECV2
 ;
 D LIST^DIC(509850.66,","_ACKVIEN_",",".01","I","*","","","","","","ACKTGT1","ACKMSG1")
 S ACKSCND=$O(ACKTGT1("DILIST",1,""))
 I ACKSCND'="" S ACKSCND=ACKTGT1("DILIST",1,ACKSCND)
 Q +ACKSCND                     ;  First Secondary Provider V.3.
 ;
ASPDIV(ACKDIV) ; returns true if ACKDIV is a valid ASP division
 N ACKTGT,ACKMSG,ACKFND
 ; look for the Division on the Site Parameters file
 D FIND^DIC(509850.83,",1,","","","`"_ACKDIV,1,"","","","ACKTGT","ACKMSG")
 ; get number found
 S ACKFND=$P($G(ACKTGT("DILIST",0)),U,1)
 Q (ACKFND=1)
CLNDIV(ACKCLN) ; returns the ien of the division that the clinic is in.
 Q $$GET1^DIQ(44,ACKCLN_",",3.5,"I")
ASPCLN(ACKCLN) ; returns true if ACKCLN is a valid clinic for ASP
 ; ACKCLN is the internal entry number from the hospital locations file
 ;  true returned if stop code is 203-Audiology, 204-Speech 
 ;   if stop code is invalid then the credit stop code field must be either 203 or 204.
 N ACKSTOP,ACKCRDT,ACKSC
 ; get ien of stop code
 S ACKSTOP=$$GET1^DIQ(44,ACKCLN_",",8,"I")
 I ACKSTOP="" Q 0  ; bad clinic record
 ; get actual stop code
 S ACKSC=$$GET1^DIQ(40.7,ACKSTOP_",",1)
 ; exit
 I ACKSC=203 Q 1  ; audiology
 I ACKSC=204 Q 1  ; speech pathology
 ; get clinic credit stop code
 S ACKCRDT=$$GET1^DIQ(44,ACKCLN_",",2503,"I")
 I ACKCRDT="" Q 0 ; no credit stop code
 ; get actual stop code
 S ACKSC=$$GET1^DIQ(40.7,ACKCRDT_",",1)
 ; exit
 I ACKSC=203 Q 1  ; audiology
 I ACKSC=204 Q 1  ; speech pathology
 Q 0  ; any other value is invalid
UC(X) ; convert X to uppercase
 Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 ;
