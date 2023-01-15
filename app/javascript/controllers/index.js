import { Application } from "@hotwired/stimulus"
import Lightbox from "bs5-lightbox"

const application = Application.start()
application.register('lightbox', Lightbox)
