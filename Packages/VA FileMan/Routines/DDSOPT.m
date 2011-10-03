DDSOPT ;SFISC/MLH,MKO-SCREENMAN OPTIONS ;07:32 AM  15 Jul 1994
 ;;22.0;VA FileMan;;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
0 S DIC="^DOPT(""DDS"","
 G OPT:$D(^DOPT("DDS",1)) S ^(0)="SCREENMAN OPTION^1.01" K ^("B")
 F X=1:1:4 S ^DOPT("DDS",X,0)=$P($T(@X),";;",2)
 S DIK=DIC D IXALL^DIK
OPT ;
 S DIC(0)="AEQIZ" D ^DIC G Q:Y<0 S DI=+Y D EN G 0
 ;
EN ;Entry point for all screenman options
 D @DI W !!
Q K %,DI,DIC,DIK,X,Y Q
 ;
1 ;;EDIT/CREATE A FORM
CREATE G ^DDGF
 ;
2 ;;RUN A FORM
 G ^DDSRUN
 ;
3 ;;DELETE A FORM
 G ^DDSDFRM
 ;
4 ;;PURGE UNUSED BLOCKS
 G ^DDSDBLK
