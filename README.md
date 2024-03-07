Реализовано:
- RandomMockServer, который генерирует изменения для каждого подмассива DataSource и отдаёт их в completion
- ViewController с таблицей, который подписывается на изменения от RandomMockServer и вызывает метод updateTableCell
- updateTableCell распределяет изменения по ячейкам таблицы, вызывая для каждой cell.updateItem
- updateItem определяет разницу с исходным массивом и обновляет содержимое CollectionViewCell, благодаря чему анимация scale ячейки при нажатии не прерывается во время обновления контента
