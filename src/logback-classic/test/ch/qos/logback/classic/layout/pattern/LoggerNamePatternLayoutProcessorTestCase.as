package ch.qos.logback.classic.layout.pattern {
	import ch.qos.logback.classic.entry.DefaultLoggerEntry;

	import org.flexunit.Assert;
	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public class LoggerNamePatternLayoutProcessorTestCase {
		
		private var reference:LoggerNamePatternLayoutProcessor;
		
		[Before]
		public function setup():void {
			this.reference = new LoggerNamePatternLayoutProcessor();
		}
		
		[Test]
		public function testTest():void {
			var tests:Array = ['%logger', '%lo', '%c', '%25logger',
				'%25.25logger', '%25.25logger{25}'];
				
			for each (var test:String in tests) {
				Assert.assertTrue("Failed to match '" + test + "'.",
					this.reference.test(test));	
			}
			
			Assert.assertFalse("Failed to reject an unrelated string.",
				this.reference.test("%farfignugen"));
		}
		
		[Test]
		public function testApply():void {
			Assert.assertEquals("Failed to simply insert the logger name.",
				"com.tkassembled.fabulous.Fabulous", this.reference.apply("%logger",
					new DefaultLoggerEntry("com.tkassembled.fabulous.Fabulous")));
			
			Assert.assertEquals("Failed to trim string to 10.",
				"c.t.f.Fabulous", this.reference.apply("%logger{10}", 
					new DefaultLoggerEntry("com.tkassembled.fabulous.Fabulous")));
					
			Assert.assertEquals("Failed to trim string to 25.",
				"c.t.fabulous.Fabulous", this.reference.apply("%logger{25}",
					new DefaultLoggerEntry("com.tkassembled.fabulous.Fabulous")));
					
			Assert.assertEquals("Failed to left-pad and trim the string.",
				"     c.t.fabulous.Fabulous", this.reference.apply("%26logger{25}",
					new DefaultLoggerEntry("com.tkassembled.fabulous.Fabulous")));
					
			Assert.assertEquals("Failed to right-pad and trip the string.",
				"c.t.fabulous.Fabulous     ", this.reference.apply("%-26logger{25}",
					new DefaultLoggerEntry("com.tkassembled.fabulous.Fabulous")));
		}
		
		[Test]
		public function testShrink():void {
			Assert.assertEquals("Failed to leave string alone.",
				"com.tkassembled.fabulous.Fabulous", this.reference.shrink("com.tkassembled.fabulous.Fabulous", 1000));
			
			Assert.assertEquals("Failed to trim string to 10.",
				"c.t.f.Fabulous", this.reference.shrink("com.tkassembled.fabulous.Fabulous", 10));
				
			Assert.assertEquals("Failed to trim string to 25.",
				"c.t.fabulous.Fabulous", this.reference.shrink("com.tkassembled.fabulous.Fabulous", 25));
		}
	}
}
