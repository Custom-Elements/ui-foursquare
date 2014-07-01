#ui-foursquare
----

    Polymer 'ui-foursquare',
      ready: () -> 
        @selectedElement=false
        @currentX=0
        @currentY=0
        @currentMatrix=0

      startMove:(evt) ->
        @selectedElement = evt.target
        @currentX = evt.clientX
        @currentY = evt.clientY
        @currentMatrix = @selectedElement.getAttributeNS(null, "transform").slice(7, -1).split(" ")
        i = 0

        while i < @currentMatrix.length
          @currentMatrix[i] = parseFloat(@currentMatrix[i])
          i++

      moveElement:(evt) ->
        return if !@selectedElement
        dx = evt.clientX - @currentX
        dy = evt.clientY - @currentY
        @currentMatrix[4] += dx
        @currentMatrix[5] += dy
        newMatrix = "matrix(" + @currentMatrix.join(" ") + ")"
        @selectedElement.setAttributeNS null, "transform", newMatrix
        @currentX = evt.clientX
        @currentY = evt.clientY

      endMove:() ->
        return if !@selectedElement
        pointOnGraphCallback @currentX, @currentY
        @selectedElement = false