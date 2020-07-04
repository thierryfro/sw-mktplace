import Viewer from 'viewerjs';

import 'viewerjs/dist/viewer.css';

const viewerJS = () => {
  const viewer = document.getElementById('image')
  if (viewer) {
    new Viewer( viewer, {
      modal: true,
      viewed() {},
    });
  }
}
// View an image

export { viewerJS }
