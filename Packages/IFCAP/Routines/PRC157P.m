PRC157P ;VMP/RB - ADD WARNING TO FILE DESCRIPTIONS #410, #442, #443.6 ;08/01/11
 ;;5.1;IFCAP;**157**;Jul 1, 2011;Build 2
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;;
 ;
 ; Post install to add warning '*********DO NOT RE-INDEX THIS FILE
 ; *********' to file description for file#: 410, 442, and 443.6.
 ;
 Q
SET ;set files
 S TMP("WP",1)="    *********DO NOT RE-INDEX THIS FILE**********"
 D WP^DIE(1,"410,",4,"A","TMP(""WP"")")
 D WP^DIE(1,"442,",4,"A","TMP(""WP"")")
 D WP^DIE(1,"443.6,",4,"A","TMP(""WP"")")
EXIT ;
 W !!,"FILE 410, 442 AND 443.6 SET WITH 'DO NOT RE-INDEX' WARNING IN FILE DESCRIPTION",!!
 K TMP,DIE
 Q
