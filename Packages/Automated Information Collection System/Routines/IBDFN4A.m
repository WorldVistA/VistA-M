IBDFN4A ;ALB/CFS - ENCOUNTER FORM - (entry points for selection routines) ;5/16/2012
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**63**;APR 24, 1997;Build 80
 ;
 ;
 ;Help message when user enters '??' at selection prompt.
HELP ;
 ;
 N IBDANS,IBDSTAR
 S $P(IBDSTAR,"*",81)=""
 W !!!,IBDSTAR
 W !,"* Enter a single code or a partial code with an * (asterisk), ? (question",?79,"*"
 W !,"* mark) or partial code to retrieve and display ICD-10-CM Diagnosis codes.",?79,"*"
 W !,"*",?79,"*"
 W !,"* -  An * (asterisk) added to partial code allows users to retrieve all",?79,"*"
 W !,"*    codes that match any number of characters (including none) at the",?79,"*"
 W !,"*    location of the *.  The * (asterisk) wildcard can only exist in the",?79,"*"
 W !,"*    last position of the search string.  User has the ability to select",?79,"*"
 W !,"*    diagnosis(es) from the search results list.",?79,"*"
 W !,"*",?79,"*"
 W !,"* -  A ? (question mark in the code pattern allows users to retrieve all",?79,"*"
 W !,"*    codes that match any single character at the location of the ?.  User",?79,"*"
 W !,"*    has the ability to select diagnosis(es) from the search results",?79,"*"
 W !,"*    list.",?79,"*"
 W !,"*",?79,"*"
 W !,"* NOTE:  Enter a ? (question mark) will match exactly one character,",?79,"*"
 W !,"*        and is not the best way to find codes of varying or unpredictable",?79,"*"
 W !,"*        length.  Therefore it is recommended that an * (asterisk) be used",?79,"*"
 W !,"*        at the end of the pattern if you need to retrieve codes of varying",?79,"*"
 W !,"*        length that start with the same characters or pattern.",?79,"*"
 W !
 S DIR("A")="Press the Enter key for more help text or '^' to Exit"
 S DIR(0)="E"
 D ^DIR
 I 'Y Q
 W @IOF
 ;W !,"*",?79,"*"
 W !,"* -  The first 2 characters in the search string cannot consist of a",?79,"*"
 W !,"*    wildcard character (* or ?).",?79,"*"
 W !,"*",?79,"*"
 W !,"* -  A ""*"" and one or more ""?"" can be used at the same time within the",?79,"*"
 W !,"*    wildcard search.",?79,"*"
 W !,"*",?79,"*"
 W !,"* Diagnosis(es) Code Selection:",?79,"*"
 W !,"*",?79,"*"
 W !,"* Diagnosis(es) can be selected from the search results list to be",?79,"*"
 W !,"* included in the ICD-10 diagnosis block by:",?79,"*"
 W !,"*",?79,"*"
 W !,"*    Selecting the list item number associated with the specific code(s):",?79,"*"
 W !,"*        -  Single code (1)",?79,"*"
 W !,"*        -  Multiple codes (1,3,6,10)",?79,"*"
 W !,"*    Selecting a range of list items between two list item numbers:",?79,"*"
 W !,"*        -  Range of codes (1-5)",?79,"*"
 W !,"*    Selecting a combination of specific list item numbers and list item",?79,"*"
 W !,"*    ranges:",?79,"*"
 W !,"*        -  Multiple codes, including a range (1-5,8,11,12).",?79,"*"
 W !
 S DIR("A")="Press the Enter key for more help text or '^' to Exit"
 S DIR(0)="E"
 D ^DIR
 I 'Y Q
 W @IOF
 ;W !,"*",?79,"*"
 W !,"* - A partial code (""*"" or ""?"") allows users to retrieve all codes",?79,"*"
 W !,"*   that begin with the characters entered (e.g. E08*).  A minimum of 3",?79,"*"
 W !,"*   characters must be entered.  User has the ability to automatically add",?79,"*"
 W !,"*   the diagnosis(es) from the search results all at once or individually.",?79,"*"
 W !,IBDSTAR,!!
 ;
 Q
 ;IBDFN4A
