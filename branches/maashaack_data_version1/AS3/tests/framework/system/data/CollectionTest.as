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
  Marc Alcaraz <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2006-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):
  
*/

package system.data 
{
    import buRRRn.ASTUce.framework.TestCase;                            

    public class CollectionTest extends TestCase 
    {

        public function CollectionTest( name:String = "" )
        {
            super( name );
        }
        
        public function testInterface():void
        {
            
            var c:CollectionClass = new CollectionClass();
            
            assertTrue( c is Collection ) ;
            
            
        }         
        
    }
}

import system.data.Collection;
import system.data.Iterator;

class CollectionClass implements Collection
{

    public function CollectionClass()
    {
    }
    
    public function add(o:*):Boolean
    {
    	return o === true ;
    }
    
    public function clear():void
    {
    	
    }
    
    public function clone():*
    {
        return new CollectionClass() ;
    }    
    
    public function contains(o:*):Boolean
    {
    	return o === true ;
    }
    
    public function get(key:*):*
    {
    	return key ;
    }
    
    public function indexOf(o:*, fromIndex:uint = 0):int
    {
    	return -1 ;
    }
    
    public function isEmpty():Boolean
    {
    	return true ;
    }
    
    public function iterator():Iterator
    {
        return new IteratorClass() ;
    }    
    
    public function remove(o:*):*
    {
    	return o ;
    }
    
    public function size():uint
    {
    	return 0 ;
    }
        
    public function toSource(indent:int = 0):String
    {
        return "source" ;
    }
}

class IteratorClass implements Iterator
{

    public function IteratorClass()
    {
    }

    public function hasNext():Boolean
    {
    	return true ;
    }
    
    public function key():*
    {
    	return "key" ;
    }
    
    public function next():*
    {
    	return "next" ;
    }
    
    public function remove():*
    {
    	return "remove" ;
    }
    
    public function reset():void
    {
    	throw new Error("reset") ;
    }
    
    public function seek(position:*):void
    {
    	throw new Error( "seek:" + position ) ;
    }
}