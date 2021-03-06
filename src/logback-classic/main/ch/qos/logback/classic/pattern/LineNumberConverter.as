package ch.qos.logback.classic.pattern {
	
	import ch.qos.logback.core.Appender;
	import ch.qos.logback.core.Layout;
	import ch.qos.logback.core.Logger;
	import ch.qos.logback.core.LoggerEntry;

	import flash.system.Capabilities;
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;

	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public class LineNumberConverter extends AbstractConverter {
		
		private var expression:RegExp = new RegExp("%((?:\\-?[0-9]+)?\\.?(?:\\-?[0-9]+))?(?:L|line)");
		
		private var classNameExpression:RegExp = new RegExp("at (.*?)/");
		
		private var fileNameExpression:RegExp = new RegExp("at .*?\\[(.*?):(\\d+)\\]", "m");
		
		private var newlineExpression:RegExp = new RegExp("\\n");
		
		override public function test(pattern:String):Boolean {
			 return expression.test(pattern);
		}
		
		override public function apply(pattern:String, entry:LoggerEntry) : String {
			if (!test(pattern))
				return null;
			
			if (entry == null)
				entry = null; // avoid FDT warnings!
			
			var stacktrace:String = new Error().getStackTrace();
			
			if (!Capabilities.isDebugger || !fileNameExpression.test(stacktrace))
				return "";
			
			var matchGroup:Object = expression.exec(pattern);
			var alignment:String = matchGroup[1];
			
			var result:String = "";
			var lines:Array = stacktrace.split(newlineExpression);
			
			for each (var line:String in lines) {
				if (fileNameExpression.test(line)) {
					var lineMatch:Object = classNameExpression.exec(line);
					var className:String = lineMatch[1];
//					if it isn't a logback object, get it!
					if (!isLogbackObject(getDefinition(className))) {
						result = fileNameExpression.exec(line)[2];
						break;
					}
				} else {
					continue;
				}
			}
			
			return this.align(result, alignment);
		}
		
		public function getDefinition(name:String):* {
			try {
				return getDefinitionByName(name);
			} catch (e:Error) {
				return null;
			}
		}
		
		public function isLogbackObject(definition:*):Boolean {
			var description:XML = describeType(definition);
			for each (var interfase:XML in description.descendants("implementsInterface")) {
				var interfaceType:Class = getDefinition(interfase.attribute("type").toString());
				if (interfaceType == Logger || interfaceType == Appender || 
						interfaceType == Layout || interfaceType == Converter)
					return true;	
			}
			
			return false;
		}
	}
}
