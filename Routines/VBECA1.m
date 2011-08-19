VBECA1 ;DALOI/PWC - APIS TO RETURN BLOOD BANK DATA FOR LAB ;10/12/00  13:57
 ;;1.0;VBECS;;Apr 14, 2005;Build 35
 ;
 ; Note: This routine supports data exchange with an FDA registered
 ; medical device. As such, it may not be changed in any way without
 ; prior written approval from the medical device manufacturer.
 ; 
 ; Integration Agreements:
 ; Reference to FIND^DIC supported by IA #2051
 ; Reference to ^%DT supported by IA #10003
 ; Reference to GETS^DIQ() supported by IA #2056
 ;
 QUIT
 ; ----------------------------------------------------------------
 ;       Private Method Supports IA 3181
 ; ----------------------------------------------------------------
ABORH(PATID,PATNAM,PATDOB,PARENT) ;
 ; Return the ABO/Rh value for the DFN of the patient provided.
 ; A space will be between the values.
 ;
 ; Implement new VBECS API.
 N IFN
 D PAT^VBECA1A  ;pass DFN, return LRDFN or 0 if not found
 I '$G(IFN) Q -1
 S ABORH=""
 Q $$ABORH^VBECA1B(IFN,"ABORH")
 ;
 ;K LRERR,DIERR,ARR
 ;D GETS^DIQ(63,LRDFN_",",".05;.06","E","ARR","LRERR")
 ;S P5=ARR(63,LRDFN_",",.05,"E"),P6=ARR(63,LRDFN_",",.06,"E")
 ;S ANS=P5_" "_P6
 ;K ARR
 ;Q ANS
 ;
 ; ----------------------------------------------------------------
 ;       Private Method Supports IA 3181
 ; ----------------------------------------------------------------
ABO(PATID,PATNAM,PATDOB,PARENT) ;
 ; Return the ABO value for the DFN of the patient provided.
 ;
 ; Implement new VBECS API.
 N IFN
 D PAT^VBECA1A  ;pass DFN, return LRDFN or 0 if not found
 I '$G(IFN) Q -1
 S ABO=""
 Q $$ABORH^VBECA1B(IFN,"ABO")
 ;
 ;K LRERR,DIERR,ARR
 ;D GETS^DIQ(63,LRDFN_",",".05","E","ARR","LRERR")
 ;S P5=ARR(63,LRDFN_",",.05,"E"),ANS=P5
 ;K ARR
 ;Q ANS
 ;
 ; ----------------------------------------------------------------
 ;       Private Method Supports IA 3181
 ; ----------------------------------------------------------------
RH(PATID,PATNAM,PATDOB,PARENT) ;
 ; Return the Rh value for the DFN of the patient provided.
 ;
 ; Implement new VBECS API.
 N IFN
 D PAT^VBECA1A  ;pass DFN, return LRDFN or 0 if not found
 I '$G(IFN) Q -1
 S RH=""
 Q $$ABORH^VBECA1B(IFN,"RH")
 ;
 ;K LRERR,DIERR,ARR
 ;D GETS^DIQ(63,LRDFN_",",".06","E","ARR","LRERR")
 ;S P6=ARR(63,LRDFN_",",.06,"E"),ANS=P6
 ;K ARR
 ;Q ANS
 ;
 ; -------------------------------------------------------
 ;      Deprecated Method - Removed from IA 3181
 ; -------------------------------------------------------
AGPRES(PATID,PATNAM,PATDOB,PARENT,ARR) ; Get Antigens Present
 ; Return an array of identified antigens and antigen comments for
 ; the DFN of the patient provided.  If no antigens found, an empty
 ; array is returned ARR("AGPRES")="".
 ; 
 ; ARR = the name of the array used to store antigens.
 ;   Array will contain the name of the antigen and any antigen comments
 ;        ARR("AGPRES",n) = Antigen ^ Antigen comment
 ;
 ;K ARR
 ;N LRDFN,A,I,X,P1,P2,P1A
 ;D PAT^VBECA1A  ;pass DFN, return LRDFN or 0 if not found
 ;I 'LRDFN S ARR=-1 Q
 ;S A=0 F I=1:1 S A=$O(^LR(LRDFN,1,A)) Q:A="B"!(A="")  D
 ;. S DATA=$G(^LR(LRDFN,1,A,0))
 ;. S P1=$P(DATA,"^",1),P2=$P(DATA,"^",2)
 ;. S P1A=$P($G(^LAB(61.3,P1,0)),"^",1)
 ;. S ARR("AGPRES",I)=P1A_"^"_P2
 ;S:'$D(ARR) ARR("AGPRES")=""    ;return empty array if none found
 Q
 ;
 ; ----------------------------------------------------------------
 ;       Private Method Supports IA 3181
 ; ----------------------------------------------------------------
ABID(PATID,PATNAM,PATDOB,PARENT,ARR) ; Get Antibodies Identified
 ; Return an array of identified antibodies and antibody comments for
 ; the DFN of the patient provided.
 ; 
 ; ARR = the name of the array used to store antibodies.
 ; Array will contain the name of the antibody and any antibody comments
 ;        ARR("ABID",n) = Antibody ^ Antibody comment
 ;
 K ARR
 N IFN
 D PAT^VBECA1A  ;pass DFN, return LRDFN or 0 if not found
 I '$G(IFN) S ARR=-1 Q
 D ABID^VBECA1B(IFN) Q
 ;
 ;S A=0 F I=1:1 S A=$O(^LR(LRDFN,1.7,A)) Q:A=""  D
 ;. S DATA=$G(^LR(LRDFN,1.7,A,0))
 ;. S P1=$P(DATA,"^",1),P2=$P(DATA,"^",2)
 ;. S P1A=$P($G(^LAB(61.3,P1,0)),"^",1)
 ;. S ARR("ABID",I)=P1A_"^"_P2
 ;S:'$D(ARR) ARR("ABID")=""    ;return empty array if none found
 ;Q
 ;
 ; -------------------------------------------------------
 ;      Deprecated Method - Removed from IA 3181
 ; -------------------------------------------------------
AGAB(PATID,PATNAM,PATDOB,PARENT,ARR) ; Get RBC Antigens Absent
 ; Return an array of absent antigens and absent antigen comments for
 ; the DFN of the patient provided. 
 ; ARR = the name of the array used to store absent antigens.
 ;   Array will contain the name of the antigen and any antigen comments
 ;        ARR("AGAB",n) = Absent Antigen ^ Absent Antigen comment
 ;
 ;K ARR
 ;N LRDFN,A,I,X,P1,P2,P1A,DATA
 ;D PAT^VBECA1A  ;pass DFN, return LRDFN or 0 if not found
 ;I 'LRDFN S ARR=-1 Q
 ;S A=0 F I=1:1 S A=$O(^LR(LRDFN,1.5,A)) Q:A=""  D
 ;. S DATA=$G(^LR(LRDFN,1.5,A,0))
 ;. S P1=$P(DATA,"^",1),P2=$P(DATA,"^",2)
 ;. S P1A=$P($G(^LAB(61.3,P1,0)),"^",1)
 ;. S ARR("AGAB",I)=P1A_"^"_P2
 ;S:'$D(ARR) ARR("AGAB")=""    ;return empty array if none found
 Q
 ;
 ; ----------------------------------------------------------------
 ;       Private Method Supports IA 3181
 ; ----------------------------------------------------------------
TRRX(PATID,PATNAM,PATDOB,PARENT,ARR) ; Get Transfusion Reactions
 ; Return an array of transfusion reactions for the DFN of the
 ;   patient provided.  If no transfusion reactions found, an
 ;   empty array is returned  ARR("TRRX")=""
 ; 
 ; ARR = the name of the array used to store transfusion reactions.
 ;   Array will contain both reactions where a particular unit or
 ;   transfusion was determined to be the cause of the reaction, and
 ;   those where no unit could be identified as being the cause of the
 ;   reaction.
 ; Transaction Type is a pointer to Blood Bank Utility File #65.4
 ;      ARR("TRRX",n) = Transfusion Date/Time ^ Transaction Type
 ;
 ; Implement new VBECS API.
 K ARR
 N IFN
 D PAT^VBECA1A  ;pass DFN, return LRDFN or 0 if not found
 I '$G(IFN) S ARR=-1 Q
 D TRRX^VBECA1B(IFN) Q
 ;
 ; get the reactions associated with a particular transfusion
 ;S (A,CNT)=0 F  S A=$O(^LR(LRDFN,1.6,A)) Q:A=""  D
 ;. S DATA=$G(^LR(LRDFN,1.6,A,0))
 ;. S P1=$P(DATA,"^",1),P11=$P(DATA,"^",11) Q:P11=""   ;transaction type
 ;. S P11A=$S(P11'="":$P($G(^LAB(65.4,P11,0)),"^",1),1:"")
 ;. S CNT=CNT+1,ARR("TRRX",CNT)=P1_"^"_P11A D
 ;. . D FIND^DIC(66,,".02","A","`"_$P(DATA,"^",2),,,,,"VBECTRX")
 ;. . S ARR("TRRX",CNT)=ARR("TRRX",CNT)_"^"_VBECTRX("DILIST","ID",1,.02)_"^"_$P(DATA,"^",3) ;Added UNIT ID and COMPONENT
 ;. . S CMT=0 F  S CMT=$O(^LR(LRDFN,1.6,A,1,CMT)) Q:'CMT  S ARR("TRRX",CNT,CMT)=^LR(LRDFN,1.6,A,1,CMT,0)
 ;; now get the reactions NOT associated with a particular transfusion
 ;S A=0 F  S A=$O(^LR(LRDFN,1.9,A)) Q:A=""  D
 ;. S DATA=$G(^LR(LRDFN,1.9,A,0))
 ;. S P1=$P(DATA,"^",1),P2=$P(DATA,"^",2) Q:P2=""    ;transaction type
 ;. S P2A=$S(P2'="":$P($G(^LAB(65.4,P2,0)),"^",1),1:"")
 ;. S CNT=CNT+1,ARR("TRRX",CNT)=P1_"^"_P2A
 ;. S CMT=0 F  S CMT=$O(^LR(LRDFN,1.9,A,1,CMT)) Q:'CMT  S ARR("TRRX",CNT,CMT)=^LR(LRDFN,1.9,A,1,CMT,0)
 ;S:'$D(ARR) ARR("TRRX")=""    ;return empty array if none found
 Q
 ;
 ; -------------------------------------------------------
 ;      Private Method supports IA 3181-H
 ; -------------------------------------------------------
BBCMT(PATID,PATNAM,PATDOB,PARENT,ARR) ; Get Blood Bank Comments
 ; Return an array of blood bank comments for the DFN of the patient
 ; provided.
 ; If no comments found, an empty array is returned ARR("BBCMT")="".
 ; ARR = the name of the array that will be used to store comments.
 ;   Array will contain all the comment text.
 ;        ARR("BBCMT",n) = Blood Bank Comment Text
 ;
 K ARR
 N LRDFN,A,I,P76
 D PAT^VBECA1A  ;pass DFN, return LRDFN or 0 if not found
 I 'LRDFN S ARR=-1 Q
 S A=0 F I=1:1 S A=$O(^LR(LRDFN,3,A)) Q:A=""  D
 . S P76=$G(^LR(LRDFN,3,A,0))
 . S ARR("BBCMT",I)=P76
 S:'$D(ARR) ARR("BBCMT")=""    ;return empty array if none found
 Q
 ;
 ; -------------------------------------------------------
 ;      Deprecated Method - Removed from IA 3181
 ; -------------------------------------------------------
AUTO(PATID,PATNAM,PATDOB,PARENT,ARR) ; Get Available Autologous Units
 ; Return an array of available autologous units for the DFN of the
 ; patient provided.  If no comments found, an empty array is returned
 ; ARR("AUTO")="".  
 ; 
 ;  ARR = the name of the array that will store autologous units.
 ;  Array will contain the component type and the expiration date.
 ;       ARR("AUTO",n) = Component Type ^ Expiration Date
 ; Component Type is a pointer to Blood Product File (#66)
 ;
 ;K ARR
 ;N LRDFN,A,I,AU,AUT,CMP,COMP,CNT,DATA,EXPDT,EXP
 ;D PAT^VBECA1A  ;pass DFN, return LRDFN or 0 if not found
 ;I 'LRDFN S ARR=-1 Q
 ;I '$D(^LRD(65,"AU",LRDFN)) S ARR("AUTO")="" Q     ;no AP xref
 ;S (A,CNT)=0 F I=1:1 S A=$O(^LRD(65,"AU",LRDFN,A)) Q:A=""  D
 ;. S AUT=$G(^LRD(65,A,4)) Q:$P(AUT,"^")'=""  ; already dispositioned
 ;. S AU=$P(^LRD(65,A,8),"^",3) Q:AU'="A"     ; autologous unit
 ;. S DATA=$G(^LRD(65,A,0)),CMP=$P(DATA,"^",4),EXPDT=$P(DATA,"^",6)
 ;. S COMP=$P($G(^LAB(66,CMP,0)),"^",1)       ; ptr to blood product file
 ;. D EXPIRE(EXPDT) Q:EXP=1                   ;unit is expired
 ;. S CNT=CNT+1,ARR("AUTO",CNT)=COMP_"^"_EXPDT
 ;S:'$D(ARR) ARR("AUTO")=""    ;return empty array if none found
 Q
 ;
EXPIRE(X) ; check if date has expired
 S EXP=0,%DT="TXF" D ^%DT S X=Y K:Y<1 X
 I $D(X) S X(1)=X,%DT="T",X="N" D ^%DT S X=X(1) D
 . I $P(X,".")'>$P(Y,".") S EXP=1 Q    ; Unit expired or expires today
 . S EXP=0
 Q
