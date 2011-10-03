VAFCMGB4 ;BIR/LTL,PTD-DEMOGRAPHIC MERGE NOTIFIER ;23 SEP 97
 ;;5.3;Registration;**149,392**;Aug 13, 1993
 ;
 ;NOTE: This routine notifies the members of the
 ;      RG CIRN DEMOGRAPHIC ISSUES Mail Group upon login
 ;      that there are patients awaiting review.
 ;
CHK ;Is user a member of this mail group?
 S RGCDI=$$FIND1^DIC(3.8,,,"RG CIRN DEMOGRAPHIC ISSUES")
 S XMDUZ=DUZ,Y=RGCDI D CHK^XMA21 I '$T G END
 D:$O(^DGCN(391.98,"AST",1,0)) SET^XUS1A("!Use the Patient Data Review option to examine pending patients.")
 ;
END K RGCDI,XMDUZ,Y
 Q
