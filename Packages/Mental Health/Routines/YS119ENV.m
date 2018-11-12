YS119ENV ;SLC/KCM - Patch 119 Environment Check ; 9/15/2015 12:08
 ;;5.01;MENTAL HEALTH;**119**;Dec 30, 1994;Build 40
ENV ; make sure patch YS*5.01*105 has been installed
 I '$$PATCH^XPDUTL("YS*5.01*105") D
 . W !,"Please install patch YS*5.01*105 before proceeding with this install.",!
 . S XPDQUIT=1
 I '$$PATCH^XPDUTL("SD*5.3*649") D
 . W !,"Please install patch SD*5.3*649 before proceeding with this install.",!
 . S XPDQUIT=1
 Q
 ;
