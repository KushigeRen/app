import { Controller } from "../../../node_modules/@hotwired/stimulus"

export default class extends Controller {
  // コントローラーに紐づく要素（=フォーム）をsubmitするアクション
  submit() {
    this.element.requestSubmit()
  }
}
