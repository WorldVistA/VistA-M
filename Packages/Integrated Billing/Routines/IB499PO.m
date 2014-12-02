IB499PO ;BL/BL - PRE-INSTALL ROUTINE FOR IB*2.0*499 ;01-APR-13
 ;;2.0;INTEGRATED BILLING;**499**;01-APR-13;Build 44
 ;
 ;Purpose of this routine is to modify the help text of the .03 field of the 355.81 file
 ;DBIA 2037 data in this file is used by Registration is registering patients
 ;
 ;File data sits in ^DD(355.81,.03,21) Help text. Must find the last line and add new text
 Q
NB N INC,LINC
 S INC="",LINC=""
 F  S INC=$O(^DD(355.81,.03,21,INC)) Q:INC=""  S LINC=INC
 ;Now we have the last line check to see if it contains the newborn code NB
 Q:^DD(355.81,.03,21,LINC,0)["Newborn"
 ;Set the code
 S ^DD(355.81,.03,21,(LINC+1),0)="    NB        Newborn of Vet"
 S $P(^DD(355.81,.03,21,0),"^",3)=($P(^DD(355.81,.03,21,0),"^",3)+1)
 S $P(^DD(355.81,.03,21,0),"^",4)=($P(^DD(355.81,.03,21,0),"^",4)+1)
 Q
