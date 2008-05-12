﻿/*
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is [ES4a: ECMAScript 4 MaasHaack framework].
  
  The Initial Developer of the Original Code is
  Zwetan Kjukov <zwetan@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2006-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):
  Marc Alcaraz <ekameleon@gmail.com>

*/
package system.reflection
    {
    
    /**
     * This interface defines the object who indicates all informations about a class in the reflection pattern of system.
     */
    public interface ClassInfo extends TypeInfo
        {
        	
        /**
         * Indicates the Array representation of all members in the class.
         */
        function get members():Array;
        
        /**
         * Indicates the Array representation of all methods in the class.
         */
        function get methods():Array;        
        
        /**
         * Indicates the name of the class.
         */
        function get name():String;
        
        /**
         * Indicates the Array representation of all static member informations.
         */   
        function get staticMembers():Array;

        /**
         * Indicates the Array representation of all static method informations.
         */   
        function get staticMethods():Array;
        
        /**
         * Indicates the ClassInfo object of the super class.
         */
        function get superClass():ClassInfo;
        
        /**
         * Indicates if the specified object is dynamic.
         */
        function isDynamic():Boolean;
        
        /**
         * Indicates if the specified object is final.
         */
        function isFinal():Boolean;

        /**
         * Indicates if the specified object is instance.
         */
        function isInstance():Boolean;   
        
        /**
         * Indicates if the specified object is static.
         */
        function isStatic():Boolean;        
        
        }
    
    
    }

