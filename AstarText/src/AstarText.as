package
{
	import com.astar.AStar;
	import com.astar.Grid;
	import com.astar.Node;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.utils.getDefinitionByName;
	import flash.utils.getTimer;

	[SWF(width="500",height="500")]
	public class AstarText extends Sprite
	{
		private var grid:Grid ;
		private var gridSp:Sprite;
		private var cellSize:int = 10 ;
		public function AstarText()
		{
			grid = new Grid();
			grid.creatGrid(10,10);
//			grid.setEndNode(10,10);
//			grid.setStartNode(49,49);
			
			for(var i:int ; i < 10 ; i++){
				var arr:Array = grid.nodeArrayList ; 
				var x:int = int(Math.random()*10) ;
				var y:int = int(Math.random() *10);
				var node:Node = arr[x][y];
				if(node.walkable){
					grid.setWalkAble(x,y,false);
				}
			}
			
			gridSp = new Sprite();
			this.addChild(gridSp);
			gridSp.addEventListener(MouseEvent.CLICK , onClick);
			drawGird();
			
			

		}
		
		private function getDrawPath():void{
			var asta:AStar = new AStar();
			var time1:int ;
			var time2:int ;
			time1 = getTimer();
			if(asta.setGrid(grid)){
				var parr:Array = asta.getPath() ; 
				var opens:Array = asta.getOpens();
			}
			time2 = getTimer();
			var num:int = time2 - time1 ;
			trace(time2 -time1)
			for(var i:int = 0 ; i <parr.length; i++){
				parr[i].isPath = true ;
			}
			drawGird();
			for(i = 0 ; i <parr.length; i++){
				parr[i].isPath = false ;
			}
		}
		
		private var clickTime:int = 0 ; 
		
		protected function onClick(event:MouseEvent):void
		{
			var x:int = int(event.localX /cellSize);
			var y:int = int(event.localY / cellSize);
	
			if(grid.getNode(x,y).walkable){
				clickTime++ ; 
				if(clickTime == 1){
					grid.setStartNode(x,y);
				}
				gridSp.graphics.beginFill(0xff0000);
				gridSp.graphics.drawRect(x*cellSize , y *cellSize , cellSize , cellSize);
				if(clickTime == 2){
					grid.setEndNode(x,y);
					getDrawPath();
					clickTime = 0
				
				}
			}
		}
		
		private function drawGird():void{
			gridSp.graphics.clear()
			var arr:Array = grid.nodeArrayList ; 
			for(var i:int = 0 ; i < grid.gridRowNum ; i++){
				for(var j:int = 0 ; j < grid.gridLineNum ; j++){
					var node:Node = arr[i][j];
					gridSp.graphics.lineStyle(0);
					gridSp.graphics.beginFill(getNodeColor(node));
					gridSp.graphics.drawRect(i*cellSize , j *cellSize , cellSize , cellSize);
				}
			}
		}
		
		private function getNodeColor(_node:Node):uint
		{
			if(_node == grid.startNode){return 0xff0000};
			if(_node == grid.endNode){return 0xff0000} ;
			if(!_node.walkable){return 0x000000}
			if(_node.isPath){return 0x00ff00};
			if(_node.isFind){return 0x333333};
			return 0x0000ff ;

		}
	}
}