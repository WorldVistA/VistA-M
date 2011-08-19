DG53455P ;BIR/SAB routine to update the kill logic for the APSOD xref ON date of death field ;05/29/2002
 ;;5.3;Registration;**455**;AUG 1993
 I $O(^DD(2,.351,1,52,0)) D
 .S ^DD(2,.351,1,52,2)="I $$VERSION^XPDUTL(""PSO"")>6 D APSOD^PSOAUTOC(DA)"
 .S ^DD(2,.351,1,52,"%D",4,0)="Kill logic updated with DG*5.3*455.  Mail message sent to pharmacy when date"
 .S ^DD(2,.351,1,52,"%D",5,0)="of death is deleted to holders of PSORPH key."
 .S ^DD(2,.351,1,52,"DT")=DT,FLDLST("2,.351")=""
 .D DIEZ^DIKCUTL3(2,.FLDLST),TRIG^DICR(2,.351) K FLDLST
