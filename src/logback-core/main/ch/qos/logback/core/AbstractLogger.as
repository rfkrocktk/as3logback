package ch.qos.logback.core {
	import org.slf4fp.Logger;

	import flash.errors.IllegalOperationError;
	import flash.events.EventDispatcher;
	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public class AbstractLogger extends EventDispatcher implements Logger, org.slf4fp.Logger {
		
		private var _name:String;
		
		private var _appenders:AppenderList = new AppenderList();
		
		private var _children:LoggerList = new LoggerList();
		
		private var _parent:Logger;
		
		private var _level:Level;
		
		private var _additive:Boolean = true;
		
		private var _messageFormatter:MessageFormatter;
		
		private var _loggerEntryFactory:LoggerEntryFactory;
		
		public function AbstractLogger(name:String = null, messageFormatter:MessageFormatter = null,
				parent:Logger = null, level:Level = null, additive:Boolean = true, 
				loggerEntryFactory:LoggerEntryFactory = null) {
			this.name = name;
			this.messageFormatter = messageFormatter;
			this.parent = parent;
			this.level = level;
			this.additive = additive;
			this.loggerEntryFactory = loggerEntryFactory;
		}
		
		public function trace(message:String, args:*) : Logger {
			unsupport();
			return null;
		}

		public function debug(message:String, args:*) : Logger {
			unsupport();
			return null;
		}

		public function info(message:String, args:*) : Logger {
			unsupport();
			return null;
		}

		public function warn(message:String, args:*) : Logger {
			unsupport();
			return null;
		}

		public function error(message:String, args:*) : Logger {
			unsupport();
			return null;
		}

		public function get isTraceEnabled() : Boolean {
			return level.ge(Level.TRACE);
		}

		public function get isDebugEnabled() : Boolean {
			return level.ge(Level.DEBUG);
		}

		public function get isInfoEnabled() : Boolean {
			return level.ge(Level.INFO);
		}

		public function get isWarnEnabled() : Boolean {
			return level.ge(Level.WARN);
		}

		public function get isErrorEnabled() : Boolean {
			return level.ge(Level.ERROR);
		}
		
		[Bindable]
		public function get name():String { return _name; }
		public function set name(value:String):void { _name = value; }
		
		public function getName():String { return name; }
		
		public function setName(value:String):Logger {
			this.name = value;
			return this;
		}
		
		[Bindable]
		public function get appenders():AppenderList { return _appenders; }
		public function set appenders(value:AppenderList):void { _appenders = value; }
		
		public function getAppenders():AppenderList { return appenders; }
		
		public function setAppenders(value:AppenderList):Logger { 
			this.appenders = value;
			return this;
		}
		
		[Bindable]
		public function get children():LoggerList { return _children; }
		public function set children(value:LoggerList):void { _children = value; }
		
		public function getChildren():LoggerList { return children; }
		
		public function setChildren(value:LoggerList):Logger {
			this.children = value;
			return this;
		}
		
		[Bindable]
		public function get parent():Logger { return _parent; }
		public function set parent(value:Logger):void { _parent = value; }
		
		public function getParent():Logger { return parent; }
		
		public function setParent(value:Logger):Logger {
			this.parent = value;
			return this; 
		}
		
		[Bindable]
		public function get level():Level { return _level; }
		public function set level(value:Level):void { _level = value; }
		
		public function getLevel():Level { return level; }
		
		public function setLevel(value:Level):Logger { 
			this.level = value; 
			return this;
		}
		
		[Bindable]
		public function get additive():Boolean { return _additive; }
		public function set additive(value:Boolean):void { _additive = value; }
		
		public function getAdditive():Boolean { return additive; }
		
		public function setAdditive(value:Boolean):Logger { 
			this.additive = value;
			return this;
		}
		
		[Bindable]
		public function get messageFormatter():MessageFormatter { return _messageFormatter; }
		public function set messageFormatter(value:MessageFormatter):void { _messageFormatter = value; }
		
		public function getMessageFormatter():MessageFormatter { return this.messageFormatter; }
		
		public function setMessageFormatter(value:MessageFormatter):Logger {
			this.messageFormatter = value;
			return this;
		}
		
		[Bindable]
		public function get loggerEntryFactory():LoggerEntryFactory { return _loggerEntryFactory; }
		public function set loggerEntryFactory(value:LoggerEntryFactory):void { _loggerEntryFactory = value; }
		
		public function getLoggerEntryFactory():LoggerEntryFactory { return loggerEntryFactory; }
		
		public function setLoggerEntryFactory(value:LoggerEntryFactory):Logger { 
			this.loggerEntryFactory = value;
			return this;
		}
			
		
		private function unsupport():void {
			throw new IllegalOperationError("Subclasses must override this method!");
		}
	}
}
