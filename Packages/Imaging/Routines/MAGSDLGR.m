MAGSDLGR ;WOIFO/SEB - Delete Image Group ; [ 06/20/2001 08:56 ]
 ;;3.0;IMAGING;**8**;Sep 15, 2004
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; |                                                               |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a Class II medical device.  As such, it may not be changed    |
 ;; | in any way.  Modifications to this software may result in an  |
 ;; | adulterated medical device under 21CFR820, the use of which   |
 ;; | is considered to be a violation of US Federal Statutes.       |
 ;; +---------------------------------------------------------------+
 ;;
 Q
 ;
 ; Delete an image group (option MAG SYS-DELETE GROUP)
IMGDEL N DIC,X,Y,MAGIEN,MAGRSN,MAGGRY
 W ! S DIC=2005,DIC(0)="AENQ",DIC("A")="Enter the image group ID to delete: "
 S DIC("S")="I $P(^(0),U,10)=""""" D ^DIC
 I Y=-1 Q
 S MAGIEN=+Y
 D SHOWINFO(MAGIEN)
RSN R !!,"Enter a Reason for deletion: ",MAGRSN:DTIME
 I $E(MAGRSN)="?" W !,"Please describe why the image group is being deleted.",!,"  or enter ""^"" to cancel." G RSN
 I (MAGRSN="^")!(MAGRSN="") W !,"Deletion Canceled.  The image group was not deleted." Q
 I $L(MAGRSN)<10 W !,"Please enter a description of a few words. (more than 10 characters)",!,"  or enter ""^"" to cancel." G RSN
 I '$$CONFIRM W !,"Deletion Canceled.  The image group was not deleted." Q
 W !,"Deleting Group Images..."
 D IMAGEDEL^MAGGTID(.MAGGRY,MAGIEN,1,MAGRSN)
 I +MAGGRY(0)=0 W !!,$P(MAGGRY(0),U,2)
 E  W !!,"Image group deletion successful!"
 Q
CONFIRM() ;
 R !!,"ARE YOU SURE YOU WANT TO DELETE ALL IMAGES IN THIS GROUP ?  Y/N  N//",ANS:DTIME
 I "Nn"[ANS Q 0
 I "Yy"'[ANS Q 0
 Q 1
SHOWINFO(IEN) ;
 W !!,"Information on Selected Image :",!
 N MAGGTRG,MAGGXE
 D GETS^DIQ(2005,IEN,"5;6;15;10;7;8;42:44","ER","MAGGTRG","MAGGXE")
 W !,"IMAGE ID (IEN)",?30,IEN
 W !,"# Images in Group = ",?30,+$P($G(^MAG(2005,IEN,1,0)),U,4)
 W !,"PATIENT",?30,MAGGTRG(2005,IEN_",","PATIENT","E")
 W !,"PROCEDURE",?30,MAGGTRG(2005,IEN_",","PROCEDURE","E")
 W !,"PROCEDURE/EXAM DATE/TIME",?30,MAGGTRG(2005,IEN_",","PROCEDURE/EXAM DATE/TIME","E")
 W !,"SHORT DESCRIPTION",?30,MAGGTRG(2005,IEN_",","SHORT DESCRIPTION","E")
 W !,"TYPE",?30,$G(MAGGTRG(2005,IEN_",","TYPE INDEX","E"))
 W !,"SPEC/SUBSPEC",?30,$G(MAGGTRG(2005,IEN_",","SPEC/SUBSPEC INDEX","E"))
 W !,"PROC/EVENT",?30,$G(MAGGTRG(2005,IEN_",","PROC/EVENT INDEX","E"))
 W !,"DATE/TIME IMAGE SAVED",?30,MAGGTRG(2005,IEN_",","DATE/TIME IMAGE SAVED","E")
 W !,"IMAGE SAVE BY",?30,MAGGTRG(2005,IEN_",","IMAGE SAVE BY","E")
 Q
