DENTDNQ2 ;WASH ISC/TJK,JA-SCREEN INPUT-QUESTIONMARKS (PART 2) ;8/28/92  12:26
 ;;1.2;DENTAL;***15**;Oct 08, 1992
FUNC X DJCP
 W DJHIN X XY W "COMMANDS",DJLIN,!
 W "^   -- Quit",?41,"@  -- Delete data"
 W !,"^nn -- Go to the 'nn' statement",?41,"CR -- Go to the next statement"
 W !,"^C  -- Command menu display",?41,"<  -- Go to previous statement"
 W !,"^R  -- Repaint Screen",?41,"?? -- For more information about field"
 W !,"    -- Space bar, recall previous answer",?41," ? -- Information about field"
 W !,"^D  -- Down page",?41,"^U -- Up page"
 W !,"Note: (C)omputed, (M)ultiple, (W)ord processing, (R)ead only"
 Q
FUNC2 X DJCP
 W DJHIN X XY W "COMMANDS",DJLIN,!
 W "^ -- Quit",?41,"^nn -- Go to the 'nn' statement"
 W !,"@ -- delete data",?41,"CR  -- Go to the next statement"
 W !,"  -- Space bar, recall previous record",?41,"<   -- Go to previous statement"
 W !,"? -- Help prompt",?41,"?? -- For more information about field"
 W !,"^C -- Command menu display"
 W !,"^L -- List current elements"
 W !,"Note: (C)omputed, (M)ultiple, (W)ord processing, (R)ead only"
 Q
