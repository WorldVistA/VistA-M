XUSER3 ;ISF/RWF - New Person File Utilities ;02/01/2022
 ;;8.0;KERNEL;**688,689**;Jul 10, 1995;Build 113
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
VALN1DEA(X,F) ;Check for a valid DEA# in the NEW DEA FIELD OF FILE #200, 53.21, .01
 ;Returns 0 for NOT Valid, 1 for Valid
 ;F = 1 for Facility DEA check.
 S F=$$FACILITY(X)
 I $D(X) I $L(X)>9 K X D EN^DDIOL($C(7)_"Exceeds maximum length (9).")
 I $D(X) I $L(X)<9 K X D EN^DDIOL($C(7)_"Less than minimum length (9).")
 I $D(X) I '(X?2U7N) K X D EN^DDIOL($C(7)_"Invalid format. Must be 2 upper case letters followed by 7 digits.")
 S F=$G(F)
 I $D(X),'F,$D(DA(1)),$D(^VA(200,"PS4",X)),$O(^(X,0))'=DA(1) D EN^DDIOL($C(7)_"Provider DEA number is already associated to another profile. Please check the number entered.") K X
 I $D(X),'$$DEANUM(X) D EN^DDIOL($C(7)_"DEA number is invalid.  Please check the number entered.") K X
 I $D(X),'F,$D(DA(1)),$E(X,2)'=$E($P(^VA(200,DA(1),0),"^")) D EN^DDIOL($C(7)_"DEA number doesn't match provider's last name. Please verify the information.") D VALN1P
 Q $D(X)
 ;
VALN1P  ; PAUSE AFTER CHECK SECOND LETTER MESSAGE
 N DIR,X,Y
 S DIR("A")="Type <Enter> to continue",DIR(0)="E" D ^DIR
 Q
 ;
VALN2DEA(X,F,DEADA) ;Check for a valid DEA# in the (NEW) DEA NUMBERS FILE #8991.9
 ;Returns 0 for NOT Valid, 1 for Valid
 ;F = 1 for Facility DEA check.
 I $D(X) I $L(X)>9 K X D EN^DDIOL($C(7)_"Exceeds maximum length (9).")
 I $D(X) I $L(X)<9 K X D EN^DDIOL($C(7)_"Less than minimum length (9).")
 I $D(X) I '(X?2U7N) K X D EN^DDIOL($C(7)_"Invalid format. Must be 2 upper case letters followed by 7 digits.")
 S F=$G(F)
 S DEADA=$G(DEADA)
 I $D(X),'$$DEANUM(X) D EN^DDIOL($C(7)_"DEA number is invalid.  Please check the number entered.") K X
 Q $D(X)
 ;
DEANUM(X) ;Check DEA # Numeric Part
 N VA1,VA2
 S VA1=$E(X,3)+$E(X,5)+$E(X,7)+(2*($E(X,4)+$E(X,6)+$E(X,8)))
 S VA1=VA1#10,VA2=$E(X,9)
 Q VA1=VA2
 ;
FACILITY(X) ;
 N DNDEAIEN
 S DNDEAIEN=$O(^XTV(8991.9,"B",X,0)) Q:'DNDEAIEN 0
 Q $$GET1^DIQ(8991.9,DNDEAIEN,.07,"I")=1
 ;
SUFCHK(X,DA) ;Check for a unique suffix. Called from Sub-File #200.5321 field #.02
 N RESPONSE S RESPONSE=0
 G:'$D(X) SUFCHKQ G:'$D(DA) SUFCHKQ G:'$D(DA(1)) SUFCHKQ
 N NPDEATXT S NPDEATXT=$$GET1^DIQ(200.5321,DA_","_DA(1),.01) G:NPDEATXT="" SUFCHKQ
 I $D(^VA(200,"F",NPDEATXT,X)) D EN^DDIOL($C(7)_"That Suffix is in use.  ","","!,?5") S RESPONSE=1
SUFCHKQ ; Unique Suffix Quit Tag
 Q RESPONSE
 ;
VDEADNM(RETURN,NPIEN)  ;ISP/RFR - Verify a provider is properly configured for ePCS
 ;PARAMETERS: NPIEN  - Internal Entry Number in the NEW PERSON file (#200)
 ;            RETURN - Reference to an array in which text explaining
 ;                     deficiencies and listing prescribable schedules
 ;                     is placed, with each deficiency and the list of
 ;                     schedules on a separate node
 ;RETURN: 1 - Provider is properly configured for ePCS
 ;        0 - Provider is not properly configured for ePCS
 ;
 N CNT,NPDEAIEN,DNDEAIEN,DNDEATXT,NPDEALST,X,Y,DEA,RETVAL,USING
 S RETVAL=1,USING=""
 S NPDEALST(0)=0
 S NPDEAIEN=0 F  S NPDEAIEN=$O(^VA(200,NPIEN,"PS4",NPDEAIEN)) Q:'NPDEAIEN  D
 . S NPDEALST(0)=NPDEALST(0)+1
 . S NPDEALST(NPDEALST(0))=$$GET1^DIQ(200.5321,NPDEAIEN_","_NPIEN_",",.01)
 . S $P(NPDEALST(NPDEALST(0)),U,2)=$$GET1^DIQ(200.5321,NPDEAIEN_","_NPIEN_",",.02)
 . S $P(NPDEALST(NPDEALST(0)),U,3)=$$GET1^DIQ(200.5321,NPDEAIEN_","_NPIEN_",",.03,"I")
 . S $P(NPDEALST(NPDEALST(0)),U,4)=NPDEAIEN_","_NPIEN_","
 . S:$P(NPDEALST(NPDEALST(0)),U,3) $P(NPDEALST(NPDEALST(0)),U,5)=$$GET1^DIQ(8991.9,$P(NPDEALST(NPDEALST(0)),U,3)_",",1.6)
 . S NPDEALST("B",$P(NPDEALST(NPDEALST(0)),U,1))=NPDEALST(NPDEALST(0))
 I NPDEALST(0)=0 S RETVAL=0 Q $$VDEADNX(RETVAL,USING)
 I NPDEALST(0)=1 D  Q $$VDEADNX(RETVAL,USING)
 . S USING=$P(NPDEALST(1),U,1)
 . S DNDEAIEN=$P(NPDEALST(1),U,3)
 . I 'DNDEAIEN S RETURN("No link to the DEA NUMBERS FILE.")="",RETVAL=0
 . S RETVAL=$$VDEADNA^XUSER3(.RETURN,NPIEN,DNDEAIEN)
 W !!,"This provider has multiple DEA registrations.",!
 W "Please select the DEA number you wish to check:",!!
 F CNT=1:1:NPDEALST(0) D
 . W $E("    ",1,5-$L(CNT)),CNT," - ",$P(NPDEALST(CNT),U,1)
 . W:$P(NPDEALST(CNT),U,2)'="" "-",$P(NPDEALST(CNT),U,2)
 . W " ",$P(NPDEALST(CNT),U,5)
 . W:$O(NPDEALST(CNT)) !
 K DIRUT,DIR S DIR(0)="F^1:2^K:'$D(NPDEALST(X))!(X=0) X"
 S DIR("A")="Choose 1 - "_NPDEALST(0)
 S DIR("A",1)=" "
 S DIR("?")="Select a choice from the list above."
 D ^DIR
 W !!
 I $G(DIRUT) S RETVAL=0 Q $$VDEADNX(RETVAL,USING)
 I '$G(X) S RETVAL=0 Q $$VDEADNX(RETVAL,USING)
 S USING=$P(NPDEALST(X),U,1)
 S DNDEAIEN=$P(NPDEALST(X),U,3)
 I 'DNDEAIEN S RETURN("No link to the DEA NUMBERS FILE.")="",RETVAL=0 Q RETVAL
 S RETVAL=$$VDEADNA^XUSER3(.RETURN,NPIEN,DNDEAIEN)
 Q RETVAL_U_USING
 ;
VDEADNX(RETVAL,USING)  ; -- Common Quit Point.
 Q RETVAL_U_USING
 ;
VDEADNA(RETURN,NPIEN,DNDEAIEN)  ; -- ENTRY POINT for a single DEA Number
 N DATE,DELIMIT,DNDEATXT,INDEX,NODEA,RETVAL,SCH,STATUS,USING
 S RETVAL=1
 I +$G(NPIEN)=0 S RETVAL=0 Q RETVAL
 I +$G(DNDEAIEN)=0 S RETVAL=0 Q RETVAL
 S DNDEATXT=$$GET1^DIQ(8991.9,DNDEAIEN,.01)
 I '$D(^VA(200,NPIEN,"PS4","B",DNDEATXT)) S RETURN("User isn't linked to the DEA Number.")="" S RETVAL=0 Q RETVAL
 S USING="Using DEA # "_DNDEATXT_","
 S STATUS=$$ACTIVE^XUSER(NPIEN)
 I STATUS="" S RETURN("User account does not exist.")="",RETVAL=0
 I STATUS=0 S RETURN("User cannot sign on.")="",RETVAL=0
 I +STATUS=0,($P(STATUS,U,2)'="") S RETURN("User account status: "_$P(STATUS,U,2))="",RETVAL=0
 Q:STATUS="" RETVAL
 I '$D(^XUSEC("ORES",NPIEN)) D
 . S RETURN("Does not hold the ORES security key.")="",RETVAL=0
 I $$GET1^DIQ(200,NPIEN,53.1,"I")'=1 D
 . S RETURN("Is not authorized to write medication orders.")="",RETVAL=0
 I $$GET1^DIQ(8991.9,DNDEAIEN,.01)'="" D
 . S DATE=+$$GET1^DIQ(8991.9,DNDEAIEN,.04,"I")
 . I DATE=0 S RETURN("Has a DEA number with no expiration date.")="",RETVAL=0,NODEA=1
 . I DATE>0,(DATE<=DT) S RETURN("Has an expired DEA number.")="",RETVAL=0,NODEA=1
 I $$GET1^DIQ(8991.9,DNDEAIEN,.01)="" D
 . S NODEA=1
 . I $$GET1^DIQ(200,NPIEN,53.3)="" D
 .. S RETURN("Has neither a DEA number nor a VA number.")="",RETVAL=0
 I +$G(NODEA),$$GET1^DIQ(200,NPIEN,53.3)'="" S RETVAL=1
 S DATE=+$$GET1^DIQ(200,NPIEN,53.4,"I")
 I DATE>0,DATE<=DT S RETURN("Is no longer able to write medication orders (inactive date).")="",RETVAL=0
 I $$GET1^DIQ(8991.9,DNDEAIEN,.07,"E")="INDIVIDUAL" D
 . S SCH("2")=$$GET1^DIQ(8991.9,DNDEAIEN,2.1,"I"),SCH("2N")=$$GET1^DIQ(8991.9,DNDEAIEN,2.2,"I")
 . S SCH("3")=$$GET1^DIQ(8991.9,DNDEAIEN,2.3,"I"),SCH("3N")=$$GET1^DIQ(8991.9,DNDEAIEN,2.4,"I")
 . S SCH("4")=$$GET1^DIQ(8991.9,DNDEAIEN,2.5,"I"),SCH("5")=$$GET1^DIQ(8991.9,DNDEAIEN,2.6,"I")
 I $$GET1^DIQ(8991.9,DNDEAIEN,.07,"E")'="INDIVIDUAL" D
 . S SCH("2")=$$GET1^DIQ(200,NPIEN,55.1,"I"),SCH("2N")=$$GET1^DIQ(200,NPIEN,55.2,"I")
 . S SCH("3")=$$GET1^DIQ(200,NPIEN,55.3,"I"),SCH("3N")=$$GET1^DIQ(200,NPIEN,55.4,"I")
 . S SCH("4")=$$GET1^DIQ(200,NPIEN,55.5,"I"),SCH("5")=$$GET1^DIQ(200,NPIEN,55.6,"I")
 I SCH("2")+SCH("2N")+SCH("3")+SCH("3N")+SCH("4")+SCH("5")=0 S RETURN("Is not permitted to prescribe any schedules.")="",RETVAL=0 Q RETVAL
 I SCH("2")+SCH("2N")+SCH("3")+SCH("3N")+SCH("4")+SCH("5")=6 S RETURN("Is permitted to prescribe all schedules.")="",RETVAL=1 Q RETVAL
 S SCH("TOTAL")=""
 S:SCH("2") SCH("TOTAL")=SCH("TOTAL")_"II NARCOTIC^"
 S:SCH("2N") SCH("TOTAL")=SCH("TOTAL")_"II NON-NARCOTIC^"
 S:SCH("3") SCH("TOTAL")=SCH("TOTAL")_"III NARCOTIC^"
 S:SCH("3N") SCH("TOTAL")=SCH("TOTAL")_"III NON-NARCOTIC^"
 S:SCH("4") SCH("TOTAL")=SCH("TOTAL")_"IV^"
 S:SCH("5") SCH("TOTAL")=SCH("TOTAL")_"V^"
 S DELIMIT=", "
 S SCH("TEXT")=""
 F INDEX=1:1:($L(SCH("TOTAL"),U)-1) D
 . S:INDEX=($L(SCH("TOTAL"),U)-1) DELIMIT=$S(($L(SCH("TOTAL"),U)-1)=2:" and ",1:", and ")
 . S SCH("TEXT")=$S(SCH("TEXT")'="":SCH("TEXT")_DELIMIT,1:"")_$P(SCH("TOTAL"),U,INDEX)
 S RETURN("Is permitted to prescribe schedule"_$S(($L(SCH("TOTAL"),U)-1)>1:"s",1:"")_" "_SCH("TEXT")_".")=""
 Q RETVAL
