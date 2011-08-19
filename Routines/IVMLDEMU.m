IVMLDEMU ;ALB/KCL - IVM DEMOGRAPHIC UPLOAD UTILITIES ; 05-MAY-94
 ;;Version 2.0 ; INCOME VERIFICATION MATCH ;; 21-OCT-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;
 ;
UPLOAD(DFN,IVMPTR,IVMFIELD,IVMVALUE) ; - file demographic fields received from IVM
 ;
 ;  Input:      DFN  --  as patient IEN
 ;           IVMPTR  --  as pointer to the FILE (#1) file.
 ;         IVMFIELD  --  as the field number to be updated
 ;         IVMVALUE  --  as the value of the field
 ;
 ; Output: None
 ;
 N DA,DIE,DR,X
 Q:'$D(DFN)!('$D(IVMPTR))!('$D(IVMFIELD))!('$D(IVMVALUE))
 S DIE=$G(^DIC(IVMPTR,0,"GL")) Q:DIE']""
 S DA=DFN,DR=IVMFIELD_"////^S X=IVMVALUE"
 D ^DIE
 Q
 ;
 ;
DELENT(IVMSUB2,IVMSUB1,IVMSUB) ; - delete entry - demographic upload data from (#301.5) sub-file
 ;
 ;  Input: IVMSUB2  --  as DA(2) of (#301.511) sub-file
 ;         IVMSUB1  --  as DA(1) of (#301.511) sub-file
 ;          IVMSUB  --  as DA of (#301.511) sub-file
 ;
 ; Output: None
 ;
 N DA,DIK,X,Y
 S DA(1)=IVMSUB1,DA(2)=IVMSUB2,DA=IVMSUB
 S DIK="^IVM(301.5,"_DA(2)_",""IN"","_DA(1)_",""DEM"","
 D ^DIK
 Q
 ;
 ;
RUSURE(IVMFIELD,IVMACT) ; - are you sure about the action?
 ;
 ;
 ;  Input:  IVMWHERE  --  "NON" for a non-uploadable field
 ;                        "UP"  for a uploadable field
 ;          IVMFIELD  --  Free-text name of field to be deleted
 ;            IVMACT  --  as action taken 'update' or 'delete'
 ;
 ; Output:   IVMOUT  --  1 for '^', 2 for time-out, 0 otherwise
 ;          IVMSURE  --  1 for 'YES', 0 for 'NO'
 ;
 ; - set screen to full scrolling region
 D FULL^VALM1
 ;
 S:$G(IVMFIELD)="" IVMFIELD="<FIELD UNSPECIFIED>"
 ;
 ; - programmer supplied prompt
 W ! S DIR("A")="Okay to "_IVMACT_" the "_IVMFIELD_" field",DIR(0)="Y"
 ;
 ; - set array of additional help if user enters single '?'
 I IVMACT="delete" D
 .S DIR("?",1)="If 'Y'es is entered at this prompt, the entry will be removed from the list."
 .S DIR("?",2)="If 'N'o is entered at this prompt, the entry will remain on the list."
 .S DIR("?",3)="Once an entry has been purged from the list, any upload data for that entry "
 .S DIR("?")="will be deleted."
 ;
 ; - set array of additional help if user enters single '?'
 I IVMACT="update" D
 .S DIR("?",1)="If 'Y'es is entered at this prompt, the field will be updated and"
 .S DIR("?",2)="the entry will be removed from the list."
 .S DIR("?",3)=" "
 .S DIR("?",4)="If 'N'o is entered at this prompt, the entry will remain on the list."
 .S DIR("?",5)=""
 .S DIR("?",6)="An entry will remain on the list untill an 'UF' - Upload Field action or a"
 .S DIR("?")="'DF' - Delete Field action has been completed."
 ;
 ; - set default='YES'
 S DIR("B")="YES"
 D ^DIR
 S IVMSURE=$G(Y)
 S IVMOUT=$S($D(DTOUT):2,$D(DUOUT):1,$D(DIROUT):1,1:0)
 ;
 ; - refresh the screen and reset the scrolling region
 S VALMBCK="R"
 ;
 K DIR,DIROUT,DTOUT,DUOUT,Y
 Q
 ;
RESET ; Reset IVMENT4 before returning to routine IVMLDEM4.
 ;  Input:  IVMENT4
 ;          VALMY array
 ;  Output: A re-set value of IVMENT4
 N IND,X
 S X=IVMENT4 F  S X=$O(VALMY(X)) Q:'X  S IND=$$ADDR(X) Q:'IND  S IVMENT4=X
 Q
 ;
ADDR(X) ; Is the corresponding field an address?
 ;  Input:  X  --  VALMY subscript which is an array index
 ;  Output: 1  --  Yes
 ;          0  --  No
 N PTR,Y
 S Y=$G(^TMP("IVMUPLOAD",$J,"IDX",X,X))
 S PTR=+$O(^IVM(301.92,"B",$P(Y,"^",8),0))
 Q $D(^IVM(301.92,"AD",PTR))>0
