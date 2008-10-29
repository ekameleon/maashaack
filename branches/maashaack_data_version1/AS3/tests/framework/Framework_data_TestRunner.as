﻿/*
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is [MaasHaack framework]
  
  The Initial Developer of the Original Code is
  Zwetan Kjukov <zwetan@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2006-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):
  
*/

package
{
    import buRRRn.ASTUce.*;
    
    import system.*;
    import system.data.*;
    import system.ui.TextFieldConsole;
    
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    import flash.text.TextField;
    import flash.text.TextFormat;    

    public class Framework_data_TestRunner extends Sprite
    {
        
        public function Framework_data_TestRunner()
        {
            
            // init
            
            stage.align     = StageAlign.TOP_LEFT;
            stage.scaleMode = StageScaleMode.NO_SCALE;
            
            textfield                   = new TextField() ;
            textfield.defaultTextFormat = new TextFormat( "Courier New" , 14 , 0xFFFFFF ) ; 
            textfield.multiline         = true ;
            textfield.selectable        = true ;
            textfield.wordWrap          = true ;
                
            addChild( textfield ) ;
                
            stage.addEventListener( Event.RESIZE , resize ) ;
            resize() ;
            
            console = new TextFieldConsole( textfield ) ;            
            
            system.config.serializer.prettyPrinting = false;
            system.about( false, false );
            
            //tests
            
            buRRRn.ASTUce.config.showConstructorList = false;
            
            Runner.main
            ( 
                system.data.AllTests.suite() // , system.AllTests.suite() 
            );
            
        }
            
        /**
         * The debug textfield of this application.
         */
        public var textfield:TextField ;            
        
        /**
         * Invoked to resize the application content.
         */
        public function resize( e:Event = null ):void
        {
            textfield.width  = stage.stageWidth ;
            textfield.height = stage.stageHeight ;
        }        
            
    }
        
}


